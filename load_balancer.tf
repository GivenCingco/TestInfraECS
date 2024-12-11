# Fetch the existing ALB
data "aws_lb" "existing_alb" {
  name = "HPO-API-LB"
}

# Fetch the existing target group
data "aws_lb_target_group" "existing_target_group" {
  name = "ALB-target-group"
}


# Listener for the ALB
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = data.aws_lb.existing_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.existing_target_group.arn
  }
}

# Outputs to reference in other files
output "alb_dns_name" {
  value = data.aws_lb.existing_alb.dns_name
}

output "target_group_arn" {
  value = data.aws_lb_target_group.existing_target_group.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.alb-listener.arn
}