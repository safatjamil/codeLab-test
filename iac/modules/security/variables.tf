variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "ssh_source_cidr" {
  description = "SSH source CIDR"
  type        = string
}

variable "http_source_cidr" {
  description = "HTTP source CIDR"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}
