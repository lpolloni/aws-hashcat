output "o_vpc_id" {
  value = "${data.aws_vpc.data_vpc.id}"
}
output "o_sg_id" {
  value = "${aws_security_group.resource_sg.id}"
}