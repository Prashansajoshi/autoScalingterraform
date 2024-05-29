resource "aws_route_table" "prashansa_route_table_public_1" {
  vpc_id = var.vpc_id

  tags = {
    Name: "prashansa_rt_public_1"
    owner: "prashansa.joshi"
  }

  route {
    cidr_block = var.all_cidr_block
    gateway_id = var.igw_id
  }
}
