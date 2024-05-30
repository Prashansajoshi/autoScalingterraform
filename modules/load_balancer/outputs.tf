output "alb_target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.prashansa_aws_alb_target_group.arn
}