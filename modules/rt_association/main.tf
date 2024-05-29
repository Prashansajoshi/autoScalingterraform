resource "aws_route_table_association" "prashansa_association_route_table_public_1" {
  subnet_id      = var.public_subnet_1_id
  route_table_id = var.public_route_table_id
}

resource "aws_route_table_association" "prashansa_association_route_table_public_2" {
  subnet_id      = var.public_subnet_2_id
  route_table_id = var.public_route_table_id
}