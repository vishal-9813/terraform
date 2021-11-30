variable "region" {
  type = string
  default = "ap-south-1"
}

variable "ec2key" {
  type = string
  default = "wordpress"
}

variable "solution_stack_name" {
  type = string
  default = "64bit Amazon Linux 2 v3.3.8 running PHP 8.0"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "applicationname" {
  type = string
  default = "wordpress"
}

variable "env" {
  type = string
  default = "develop"
}