resource "aws_security_group" "nginx_sg" {
    name = "nginx_sg"
    description = "Allow inbound traffic"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        iterator = port
        for_each = var.ports_in
        content {
            from_port = port.value
            protocol = "tcp"
            to_port = port.value
            cidr_blocks = [var.cidr_block]
        }
    }
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = var.cidr_block_open
    }
}


resource "aws_security_group" "balancer_sg" {
    name = "balancer_sg"
    description = "Allow traffic to instances through Load Balancer"
    vpc_id = var.vpc_id

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_open
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = var.cidr_block_open
  }
}