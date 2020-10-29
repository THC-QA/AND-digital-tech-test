resource "aws_instance" "jenkins" {
  ami                    = var.jenkins-ami
  instance_type          = var.instance-type
  vpc_security_group_ids = var.jenkins-sec
  subnet_id              = var.jenkins-subnet
  key_name               = var.jenkins-key
  
  user_data = data.template_file.jenkins_install.rendered
  tags = {
    Name = "jenkins-update"
  }
  
}

data "template_file" "jenkins_install" {
  template = file("../../modules/ec2/jenkins.sh")
}
