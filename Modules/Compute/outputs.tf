output "public_ip"{
    value = aws_instance.MaciejBekasDemoEasy["a"].public_ip
}