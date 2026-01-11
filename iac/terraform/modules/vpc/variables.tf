variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "172.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "igw_name" {
  description = "IGW name"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}

variable "subnet_name" {
  description = "Public subnet name"
  type        = string
}


