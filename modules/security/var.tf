variable "sg_id" {
  type = "string"
}
variable "vpc_id" {
  type = "string"
}
variable "sg_env" {
  type = "string"
}
variable "create" {
  default = true
}
variable "sg_name_env" {
  default = "string"
}
variable "ingress_rules" {
  type = "map"

  default = {
    ssh-22    = [22, 22, "tcp", "ssh"]
  }
}
variable "auto_ingress_rules" {
  type = "map"

  default = {    
    aws-hashcat        = ["ssh-22"]
  }
}