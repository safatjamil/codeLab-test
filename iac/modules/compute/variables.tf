variable "subnet_name" {
  description = "Public subnet name"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair "
  type        = string
}

variable "instance_name" {
  description = "Instance name"
  type        = string
}

