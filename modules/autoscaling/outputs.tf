output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group"
  value       = aws_autoscaling_group.prashansa_autoScaling_group.id
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.prashansa_autoScaling_template.id
}
