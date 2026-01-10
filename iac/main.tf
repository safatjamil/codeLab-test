terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "region"
}

locals {
  config = yamldecode(file(""env/${terraform.workspace}/config.yaml""))
}

module "vpc" {
    source      = "./modules/vpc"
    vpc_name    = local.config.vpc.name
    vpc_cidr    = local.config.vpc.cidr
    igw_name    = local.config.igw_name
    public_subnet_cidr = local.config.vpc.subnet.cidr
    subnet_name        = local.config.vpc.subnet.name
    availability_zone  = local.config.availability_zone
}

module "security" {
    source      = "./modules/vpc"
    vpc_name    = local.config.vpc.name
    ssh_source_cidr  =  local.config.sg.ssh_source_cidr
    http_source_cidr = local.config.sg.http_source_cidr
    security_group_name = local.config.sg.name
}

module "compute" {
    source      = "./modules/compute"
    subnet_name = local.config.vpc.subnet.name
    security_group_name = local.config.sg.name
    ami_id    = local.config.ec2.ami
    instance_type = local.config.ec2.type
    key_name      = local.config.ec2.key
    instance_name = local.config.ec2.name
}




