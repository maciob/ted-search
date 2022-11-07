output "Subnet_IDs" {
  description = "Subnet_IDs"
  value       = ["${aws_subnet.MY_SUBNETS["a"].id}"]
}
output "SEC_GROUP_ID" {
  description = "SEC_GROUP_ID"
  value       = "${aws_security_group.MaciejBekas-easy-sec-group.id}"
}
output "VPC_GROUP_ID" {
  description = "VPC_GROUP_ID"
  value       = "${aws_vpc.MaciejBekas-easy-vpc.id}"
}
