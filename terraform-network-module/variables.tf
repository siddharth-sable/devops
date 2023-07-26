# variables.tf

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "create_transit_gateway" {
  description = "Set to true if you want to create a Transit Gateway, false otherwise"
  type        = bool
  default     = false
}

variable "transit_gateway_name" {
  description = "Name of the Transit Gateway"
  type        = string
}
