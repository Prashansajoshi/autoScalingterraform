resource "aws_launch_template" "prashansa_autoScaling_template" {
  name_prefix   = "prashansa_autoScaling_template"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/../../ec2_init.sh")
  #   security_group_names = [var.security_group_id]


  metadata_options {
    http_endpoint               = "enabled"  #enables the instance metadata service on the EC2 instance.
    http_tokens                 = "required" #all requests to the instance metadata service be made with a valid session token. 
    http_put_response_hop_limit = 1          #By limiting this to 1, you're ensuring that the response doesn't get routed through multiple other systems, which can be a security risk.
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.subnet_id
    security_groups             = [var.security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "prashansa_aws_lauch_template_1"
      silo        = "intern2"
      owner       = "prashansa.joshi"
      terraform   = "true"
      environment = "dev"
    }
  }
}

resource "aws_autoscaling_group" "prashansa_autoScaling_group" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size

  launch_template {
    id      = aws_launch_template.prashansa_autoScaling_template.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"

  lifecycle {
    create_before_destroy = true
  }
}

# Scale up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = var.scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_up_cooldown
  autoscaling_group_name = aws_autoscaling_group.prashansa_autoScaling_group.name
}

# Scale up alarm
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "scale_up_alarm"
  alarm_description   = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.scale_up_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_up_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.prashansa_autoScaling_group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}

# Scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = var.scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_down_cooldown
  autoscaling_group_name = aws_autoscaling_group.prashansa_autoScaling_group.name
}

# Scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "scale_down_alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.scale_down_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.scale_down_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.prashansa_autoScaling_group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.prashansa_autoScaling_group.id
  lb_target_group_arn    = var.alb_target_group_arn
}
