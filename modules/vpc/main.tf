resource "aws-vpc" "prashansa_vpc" {
    cidr_block = var.cidr_block

    tags = {
        Name = "prashansa_vpc"
        owner = "prashansa.joshi"
        silo = "intern2"
        environment = "dev"
        terraform = "true"
    }
}