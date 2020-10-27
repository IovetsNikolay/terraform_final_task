variable "region" {
  type = string
  default = "us-east-1"
}

variable "ports_to_open" {
  type = list(string)
  default = ["22", "80", "8080"]
}

variable "ami_ids" {
  type = map(string)
  default = {
    us-east-1 = "ami-0947d2ba12ee1ff75"
  }
}

variable "instance_name" {
  type = string
  default = "Jenkins_instance"
  description = "Name of EC2 instance"
}