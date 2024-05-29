variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"  
    type = string
}

variable "subnet_cidr" {
    description = "value of subnet cidr"
    default = "10.0.1.0/24"
    type = string
}

variable "subnet_cidr_public_2" {
    description = "value of public subnet cidr 2"
    default = "10.0.2.0/24"
    type = string
}

variable "all_cidr_block" {
    description = "All CIDR block i.e 0.0.0.0/0"
    default = "0.0.0.0/0"
    type = string
}

variable "ami" {
    description = "default ami"
    default = "ami-04b70fa74e45c3917"
    type = string
}

variable "instance_type" {
  description = "instance type"
  default = "t2.micro"
}

variable "key_name" {
    description = "default keypair"
    default = "prashansa-key"
}

variable "availability_zone_1" {
    description = "Availability zone for subnet"
    default = "us-east-1a"
    type = string
}

variable "availability_zone_2" {
    description = "Availability zone for subnet"
    default = "us-east-1b"
    type = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}