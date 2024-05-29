resource "aws_internet_gateway" "prashansa_internet_gateway_1" {
  vpc_id = var.vpc_id

  tags = {
    Name = "prashansa_internet_gateway_1_terraform"
    silo = "intern2"
    owner = "prashansa.joshi"
    terraform = "true"
    environment = "dev"
  }
}