resource "aws_key_pair" "resource_kp" {

  key_name    = "kp-${var.ec2_env}" 
  public_key  = "${file("kp-${var.ec2_env}.pub")}"
}