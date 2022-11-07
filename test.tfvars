#======== COMPUTE
INSTANCES = {
  "a" = {
    az   = "eu-west-2b"
    ver  = "a" 
    name = "MaciejBekasDemoEasy"
    num = 0
  }
}
KEY_PATH = "/MaciejBekasKey.pem"
instance_type = "t2.micro"
KEY_NAME = "MaciejBekasBootcampPL"
created_by = "MaciejBekas"
bootcamp = "poland1"
ami = "ami-0f540e9f488cfa27d"
dc_source = "docker-compose-prod.yml"
dc_dest = "/home/ubuntu/docker-compose.yml"

#======== NETWORK

MY_SUBNETS = {
  "a" = {
    cidr = "10.0.0.16/28"
    az   = "eu-west-2b"
  }
}

sec_group_name = "MaciejBekas-easy-sec-group"