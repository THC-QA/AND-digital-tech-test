resource "aws_elb" "test_balancer" {
  name                      = "testbalancer"
  security_groups           = var.balancer_security_group_ids
  subnets                   = [var.pub_sub_1_id, var.pub_sub_2_id]
  cross_zone_load_balancing = true
  
  listener {
    lb_port = 80
    lb_protocol = "https"
    ssl_certificate_id = var.certificate_arn
    instance_port = "80"
    instance_protocol = "http"
  } 

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  tags = {
    Name = "test_balancer"
  }

}
resource "null_resource" "instance_wait" {
    depends_on = [ aws_elb.test_balancer ]
    triggers = {
      lb_dns_name = aws_elb.test_balancer.dns_name
    }

    provisioner "local-exec" {
      command = "sleep 180"
    }
}
data "dns_a_record_set" "dns_record" {
  depends_on = [null_resource.instance_wait]
  host  = aws_elb.test_balancer.dns_name
}