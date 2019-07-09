output "o_vpc_id" {
  value = "${aws_vpc.resource_vpc.*.id}"
}
output "o_subnet_id" {
  value = "${aws_subnet.resource_subnet.*.id}"
}
output "o_route_id" {
  value = "${aws_route_table.resource_route.*.id}"
}
output "o_igw_id" {
  value = "${aws_internet_gateway.resource_igw.*.id}"
}