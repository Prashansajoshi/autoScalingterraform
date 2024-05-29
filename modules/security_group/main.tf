resource "aws_security_group" "security_group_id_1" {
  name        = "prashansa_sg_vpc_1_terraform"
  description = "prashansa aws securitygroup built using terraform"
  vpc_id      = var.vpc_id

  ingress{
    description = "prashansa security group from terraform http"
    cidr_blocks = [var.all_cidr_block]
    from_port   = 80
    protocol = "tcp"
    to_port     = 80
  }

  ingress{
    description = "prashansa security group from terraform ssh"
    cidr_blocks   = [var.all_cidr_block]
    from_port   = 22
    protocol = "tcp"
    to_port     = 22
  }

  egress{
    description = "egress for all traffic"
    cidr_blocks = [var.all_cidr_block]
    from_port = 0
    to_port = 0
    protocol = -1
  }

  tags = {
    Name = "prashansa-aws-sg-terraform"
    terraform = "true"
    silo = "intern2"
    owner = "prashansa.joshi"
    environment = "dev"
  }
}