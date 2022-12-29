#---------------------------
#Create simple Ubuntu EC2 instance
#
#Created by xalex63
#
#Components:
#   1 Ubuntu instance
#---------------------------

provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_instance" "ubuntu" {
  ami = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"

  tags = {
    "Name" = "ubuntu-instance"
  }
}