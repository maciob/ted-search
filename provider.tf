provider "aws" {
    region = "${var.AWS_REGION}"
}
terraform{
    backend "s3"{
        bucket = "maciejbekasted"
        key = "state"
        region = "eu-west-2"
    }
}