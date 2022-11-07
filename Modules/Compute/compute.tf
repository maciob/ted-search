resource "aws_instance" "MaciejBekasDemoEasy" {
    for_each = var.INSTANCES
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = each.value.az
    subnet_id = var.Subnet_IDs["${each.value.num}"]
    key_name = var.KEY_NAME
    vpc_security_group_ids = ["${var.SEC_GROUP_ID}"]
    iam_instance_profile = "MaciejBekasTerraform"
    user_data = file("docker.sh")
    credit_specification{
        cpu_credits = "unlimited"
    }
    tags = {
        Name = each.value.name
        created_by = var.created_by
        bootcamp = var.bootcamp      
    }
    volume_tags = {
        Name = each.value.name
        created_by = var.created_by
        bootcamp = var.bootcamp
    }
}


resource "null_resource" "copy_file"{
    provisioner "file"{
        source = var.dc_source
        destination = var.dc_dest
    }
    connection{
        type = "ssh"
        host = aws_instance.MaciejBekasDemoEasy["a"].public_ip
        user = "ubuntu"
        private_key = file(var.KEY_PATH)
    }

    depends_on = [aws_instance.MaciejBekasDemoEasy["a"]]
}