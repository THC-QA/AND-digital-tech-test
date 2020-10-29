module "project-vpc" {
  source         = "../../modules/vpc"
  vpc-cidr-block = "36.216.0.0/16"
  pub-sub-block1 = "36.216.1.0/24"
  pub-sub-block2 = "36.216.2.0/24"
  region         = var.region
}

module "acm-route53" {
  source      = "../../modules/acm_route53"
  domain-name = var.domain-name
  vpc_id      = module.project-vpc.vpc_id
  region      = var.region
}

module "jenkins-ec2" {
  source         = "../../modules/ec2"
  jenkins-ami    = "ami-05c424d59413a2876"
  region         = var.region
  instance-type  = var.instance-type-input
  jenkins-sec    = ["${module.all_sec_grps.aws_jenkins_sg_id}"]
  jenkins-subnet = module.project-vpc.public_block1_id
  jenkins-key    = "ANDdigitalTechTest" ## Key Created on AWS Web Interface
}

# --- REMOTE EXEC ---

resource "null_resource" "test" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = module.jenkins-ec2.public_ip
      private_key = file("${var.key-path}")
      user        = "ubuntu"
    }
    
    inline = [

      "until [ id -u jenkins >/dev/null 2>&1 ];"
      "do"
      "sleep 5"
      "done"

      "echo 'export CERT_ARN=${module.acm-route53.cert-arn}' >> /var/lib/jenkins/.bashrc",
      "echo 'export DOMAIN_NAME=${var.domain-name}' >> /var/lib/jenkins/.bashrc",

      "sudo chown jenkins:jenkins /var/lib/jenkins/.bashrc"
      "sudo chmod 444 /var/lib/jenkins/.bashrc"
    ]
  }
}

module "all_sec_grps" {
  source = "../../modules/sec_grps"
  name   = "eks_secgrp"
  vpc_id = module.project-vpc.vpc_id
  region = var.region
  pub-sub-block = module.project-vpc.vpc-cidr
}

module "project-eks-cluster" {
  source    = "../../modules/eks"
  subnets   = ["${module.project-vpc.public_block1_id}", "${module.project-vpc.public_block2_id}"]
  secgroups = ["${module.all_sec_grps.aws_wsg_id}"]
  region    = var.region
  instance-type  = ["${var.instance-type-input}"]
}

resource "aws_autoscaling_policy" "eks-scale" {
 name                   = "eks-scale"
 policy_type            = "TargetTrackingScaling"
 autoscaling_group_name = module.project-eks-cluster.eks-asg-name

 target_tracking_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ASGAverageCPUUtilization"
   }

 target_value = 80.0
 }
}