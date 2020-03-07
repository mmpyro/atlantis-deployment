variable "network" {
  type    = string
  default = "net-network"
}

variable "subnet" {
  type    = string
  default = "k8s-subnet"
}

variable "location" {
  type    = string
  default = "europe-west3"
}

variable "project" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = ["webhook"]
}

variable "source_ranges" {
  type    = list(string)
  default = ["172.16.0.0/28"]
}