provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "ubuntu-1s" {
    ami = "ami-02d63d6d135e3f0f0" 
    instance_type = "t2.micro"

    tags = {
        Name = "Ubuntu-1804-test"
    } 
}