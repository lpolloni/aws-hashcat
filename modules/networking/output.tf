output "o-vpc-id" {
  value = aws_vpc.resource-vpc.id
}
output "o-igw-id" {
  value = aws_internet_gateway.resource-igw.id
}
output "o-subnet-id" {
  value = aws_subnet.resource-subnet.*.id
}
output "o-sgroup-id" {
  value = aws_security_group.resource-sgroup.*.id
}
