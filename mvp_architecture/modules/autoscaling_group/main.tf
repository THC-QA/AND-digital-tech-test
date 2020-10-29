resource "aws_autoscaling_group" "test_scale" {
  name = "test_scale"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 5

  health_check_type    = "ELB"
  load_balancers= [var.elb_id]

  launch_configuration = var.launch_configuration_name
  availability_zones = [var.subnet1_id, var.subnet2_id]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity="1Minute"

  vpc_zone_identifier  = [var.subnet1_id, var.subnet2_id]

  lifecycle {
    create_before_destroy = true
  }
}