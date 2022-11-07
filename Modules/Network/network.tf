resource "aws_internet_gateway" "MaciejBekas-easy-igw" {
    vpc_id = aws_vpc.MaciejBekas-easy-vpc.id
    tags = {
        Name = "MaciejBekas-easy-igw"
    }
}

resource "aws_route_table" "MaciejBekas-easy-public-crt" {
    vpc_id = aws_vpc.MaciejBekas-easy-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.MaciejBekas-easy-igw.id
    }
    tags = {
        Name = "MaciejBekas-public-crt"
    }
}

resource "aws_route_table_association" "MaciejBekas-easy-crta-public-subnet"{
    for_each = var.MY_SUBNETS
    subnet_id = aws_subnet.MY_SUBNETS[each.key].id
    route_table_id = aws_route_table.MaciejBekas-easy-public-crt.id
}

resource "aws_security_group" "MaciejBekas-easy-sec-group" {
    vpc_id = aws_vpc.MaciejBekas-easy-vpc.id
    name = var.sec_group_name
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.sec_group_name
    }
}
