#=====VAR GLOBAL

variable "AWS_REGION" {    
    default = "eu-west-2"
}

#=====VAR COMPUTE

variable "KEY_PATH"{
    type = string
}
variable "instance_type"{
    type = string
}
variable "KEY_NAME"{
    type = string
}
variable "created_by"{
    type = string
}
variable "bootcamp"{
    type = string
}
variable "ami"{
    type = string
}
variable "dc_source"{
    type = string
}
variable "dc_dest"{
    type = string
}
variable "INSTANCES"{
    type = map(object({
        az = string
        ver = string
        name = string
        num = number
    }))
}

#=====VAR NETWORK->COMPUTE

variable "Subnet_IDs"{
    type = list(string)
    default = [""]
}
variable "SEC_GROUP_ID"{
    type = string
    default = ""
}
variable "VPC_GROUP_ID"{
    type = string
    default = ""
}

#=====VAR NETWORK

variable "MY_SUBNETS"{
    type = map(object({
        cidr = string
        az = string
    }))
}

variable "sec_group_name"{
    type = string
}