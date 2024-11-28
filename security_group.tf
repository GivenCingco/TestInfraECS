/* ==========Security Group for EC2 Instances (ALB--> EC2)============*/module "EC2-security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "EC2-security-group"
  description = "Security group for ECS instances with HTTP traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  /*===Inbound Rules===*/
  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.ALB-security-group.security_group_id
      description              = "Allow traffic from ALB security group"
    },
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = module.ALB-security-group.security_group_id
      description              = "Allow traffic from ALB security group on HTTPS"
    }
  ]

  /*===Outbound Rules===*/
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

  tags = {
    Name = "EC2-SG"
  }
}


/* ==========Security Group for Application Load Balancer (Internet --> ALB)============*/

module "ALB-security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ALB-security-group"
  description = "Security group for ALB with HTTP/HTTPS access"
  vpc_id      = module.vpc.vpc_id

  /*===Inbound Rules===*/
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP traffic"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTPS traffic"
    }
  ]

  /*===Outbound Rules===*/
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

  tags = {
    Name = "ALB-SG"
  }
}


output "ec2_security_group_id" {
  value = module.EC2-security-group.security_group_id
}