provider "aws" {
  profile = "admin"
  region  = "us-east-1"
}

module "launch-template" {
  source  = "figurate/launch-template/aws"
  version = "1.0.2"

  image_id = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  name = "tform_launch_template"
}

resource "aws_autoscaling_group" "main" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  health_check_grace_period = 300
  health_check_type         = "ELB"

  load_balancers = [aws_elb.main.name]

  launch_template {
    id      = module.launch-template.launch_template_id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.name
  name = "Target Tracking Policy"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}

resource "aws_elb" "main" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 30
  }

//  instances                   = [aws_instance.foo.id]
//  cross_zone_load_balancing   = true
//  idle_timeout                = 400
//  connection_draining         = true
//  connection_draining_timeout = 400
}

