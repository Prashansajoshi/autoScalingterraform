output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group"
  value       = aws_autoscaling_group.example.id
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.example.id
}
