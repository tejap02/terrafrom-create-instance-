provider "aws" {
  region = "us-east-1"  # Change this if needed
}

data "aws_vpc" "default" {
  default = true
}

# Fetch a specific default subnet by filtering with an availability zone
data "aws_subnet" "default_subnet" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "availability-zone"
    values = ["us-east-1a"]  # Change this if needed
  }
}



resource "aws_instance" "ubuntu_instance_1" {
  ami             = "ami-04b4f1a9cf54c11d0"  # Same Ubuntu 22.04 AMI
  instance_type   = "t2.micro"
  key_name        = "mujahed"
  security_groups = ["sg-0a77c89fa61154998"]
  subnet_id       = data.aws_subnet.default_subnet.id

  tags = {
    Name = "Docker-Server"
  }
}



output "docker_server_public_ip" {
  value = aws_instance.ubuntu_instance_1.public_ip
}
