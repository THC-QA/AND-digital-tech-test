module "test_vpc" {
  source = "./vpc"
  region = var.region
}
module "test_security_groups" {
  source        = "./security_groups"
  region        = var.region
  cidr_block    = "0.0.0.0/0" # Find way of restricting to just ELB/launch point
  vpc_id        = module.test_vpc.vpc_id
}
module "test_launch_configuration" {
    source                  = "./ec2"
    region                  = var.region
    nginx_instance_key      = "ANDdigitalTechTest" # Key created on AWS web interface
    vpc_security_group_ids  = ["${module.test_security_groups.nginx_sg_id}"]
}
module "auto_scaling" {
    source                      = "./autoscaling_group"
    region                      = var.region
    launch_configuration_name   = module.test_launch_configuration.launch_config_name
    balancer_id                 = module.test_load_balancer.balancer_id 
    pub_sub_1_id                = module.vpc.pub_sub_1_id
    pub_sub2_id                 = module.vpc.pub_sub_2_id
}
module "test_load_balancer" {
    source                      = "./load_balancer"
    region                      = var.region
    pub_sub_1_id                = module.test_vpc.pub_sub_1_id
    pub_sub_2_id                = module.test_vpc.pub_sub_2_id
    certificate_arn             = 
    balancer_security_group_ids = ["${module.test_security_groups.balancer_sg_id}"]
}