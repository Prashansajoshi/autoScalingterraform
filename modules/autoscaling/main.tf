resource "aws_launch_template" "prashansa_autoScaling_template" {
  name_prefix   = "prashansa_autoScaling_template"
  image_id      = var.ami
  instance_type = var.instance_type
  #   security_group_names = [var.security_group_id]

    network_interfaces {
    associate_public_ip_address = true
    subnet_id = var.subnet_id
    security_groups = [var.security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "prashansa_autoScaling_group" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 2
  max_size           = 6
  min_size           = 2

  launch_template {
    id      = aws_launch_template.prashansa_autoScaling_template.id
    version = "$Latest"
  }
  health_check_type          = "EC2"
  health_check_grace_period  = 300
  wait_for_capacity_timeout  = "0"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.prashansa_autoScaling_group.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.prashansa_autoScaling_group.name
}

# # Create a new load balancer attachment
# resource "aws_autoscaling_attachment" "example" {
#   autoscaling_group_name = aws_autoscaling_group.example.id
#   elb                    = aws_elb.example.id
# }

# # Create Auto Scaling Group
# resource "aws_autoscaling_group" "prashansa_autoScaling_group" {
#   name                 = "prashansa_autoScaling_group"
#   desired_capacity     = 1
#   max_size             = 2
#   min_size             = 1
#   force_delete         = true
#   depends_on           = [aws_lb.prashansa_aws_alb]
#   target_group_arns    = ["${aws_lb_target_group.prashansa_aws_alb_target_group.arn}"]
#   health_check_type    = "EC2"
#   launch_configuration = aws_launch_configuration.instance-launch-config.name
#   vpc_zone_identifier  = ["${aws_subnet.prv_sub1.id}", "${aws_subnet.prv_sub2.id}"]
#   tag {
#     key                 = "Name"
#     value               = "Ugra-ASG-tf"
#     propagate_at_launch = true
#   }
# }
