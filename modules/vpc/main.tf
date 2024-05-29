resource "aws_vpc" "prashansa_terraform_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "prashansa_terraform_vpc"
        owner = "prashansa.joshi"
        silo = "intern2"
        environment = "dev"
        terraform = "true"
    }
}