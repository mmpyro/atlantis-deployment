variable "number_of_nodes" {
  default = 1
}

variable "location" {
  type    = string
  default = "europe-west3-c"
}

variable "vm_type" {
  type    = string
  default = "n1-standard-2"
}

variable "cluster_name" {
  type    = string
  default = "mmk8s-cluster"
}

variable "vpc_native" {
  type    = bool
  default = true
}

variable "release_channel" {
  type    = string
  default = "STABLE"
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "project" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = ["webhook"]
}

locals {
  node_pool_name = "default-node-pool"
  vpc_native     = [var.vpc_native]
}

