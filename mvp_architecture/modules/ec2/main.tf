resource "aws_launch_configuration" "nginx_instance" {
  image_id = var.ami 
  instance_type = var.instance_type
  key_name = var.nginx_instance_key
  security_groups = var.vpc_security_group_ids
  associate_public_ip_address = true
  user_data                   = data.template_file.frontend.rendered
}

data "template_file" "frontend" {
  template = file("../../modules/ec2/frontend.sh")
}