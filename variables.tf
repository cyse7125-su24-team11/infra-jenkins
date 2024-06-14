variable "aws_zone" {
  type    = string
  default = "us-east-1"
}
variable "vpc_name" {
  type    = string
  default = "vpc"
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}
variable "public_subnet_name" {
  type    = string
  default = "public_subnet"
}
variable "public_subnet_cidr_block" {
  type    = string
  default = "10.1.1.0/24"
}
variable "private_subnet_name" {
  type    = string
  default = "private_subnet"
}
variable "internet_gw" {
  type    = string
  default = "internet_gateway"
}
variable "private_subnet_cidr_block" {
  type    = string
  default = "10.1.2.0/24"
}
variable "route_table_name" {
  type    = string
  default = "jenkins_route_table"
}
variable "sg_name" {
  type    = string
  default = "public_sg"
}
variable "tcp_protocol" {
  type    = string
  default = "tcp"
}
variable "https_default_port" {
  type    = number
  default = 443
}
variable "app_port" {
  type    = number
  default = 8080
}
variable "app_default_port" {
  type    = number
  default = 80
}
variable "ssh_default_port" {
  type    = number
  default = 22
}
variable "internet_gateway" {
  type    = string
  default = "0.0.0.0/0"
}
variable "packer_image" {
  type    = string
  default = "ami-0e0725bac36ba271c"
}
variable "jenkins_key" {
  type    = string
  default = "ec2ssh"
}
variable "jenkins_ec2_instance_type" {
  type    = string
  default = "t2.medium"
}
variable "jenkins_ec2" {
  type    = string
  default = "jenkins"
}
variable "eip_tag" {
  type    = string
  default = "tag:instance"
}