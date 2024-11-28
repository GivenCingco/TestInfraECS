resource "aws_lb" "app_lb" {
  name               = "HPO-API-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.ALB-security-group.security_group_id]
  subnets            = module.vpc.public_subnets
  depends_on         = [module.vpc.vpc_id]


  tags = {
    Environment = "production"
  }
}

#Target group group for ALB
resource "aws_lb_target_group" "alb-target-group" {
  name        = "ALB-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = "80"
  protocol            = "HTTP"
  }

  tags = {
    Name = "ALB-target-group"
  }
}

#Listerner for ALB
resource "aws_lb_listener" "alb-listerner" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

#Outputs
output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}