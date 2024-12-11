module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "ecs-instance"

  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key_name.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.EC2-security-group.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("user-data.sh")


}