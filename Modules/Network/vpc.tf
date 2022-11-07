resource "aws_vpc" "MaciejBekas-easy-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"    
    enable_dns_support = "true"
    enable_dns_hostnames = "true"   
    tags = {
        Name = "MaciejBekas-easy-vpc"
    }
}
resource "aws_subnet" "MY_SUBNETS" {
    for_each = var.MY_SUBNETS
    vpc_id = "${aws_vpc.MaciejBekas-easy-vpc.id}"
    cidr_block = each.value.cidr
    availability_zone = each.value.az
    map_public_ip_on_launch = "true" //it makes this a public subnet

    tags = {
        Name = "MaciejBekas-easy-public-${each.value.az}"
    }
}
