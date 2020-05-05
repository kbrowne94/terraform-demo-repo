variable "deploy_region" {}
variable "access_key" {}
variable "scret_key" {}


provider "aws" {
  region     = "${var.deploy_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


resource "aws_security_group" "demo_allow_http_ssh" {
  name        = "demo_allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.demo_allow_http_ssh.name}"]

  tags = {
    Name = "HelloWorld"
  }
}


