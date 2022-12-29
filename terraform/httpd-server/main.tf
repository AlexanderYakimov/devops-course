#---------------------------
#Build Webserver during Bootstrap
#
#Created by xalex63
#
#Components:
#   1 Amazon Linux instance
#   1 Security Group
#---------------------------

provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_eip" "httpd1-static-ip" {
    instance = aws_instance.httpd-1.id
}

resource "aws_instance" "httpd-1" {
    ami = "ami-05ff5eaef6149df49"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow-http.id]
    user_data = file("httpd.sh")

    tags = {
      "Name" = "httpd-1"
    }

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "allow-http" {
    name = "allow-http"
    description = "Allow HTTP/S traffic"

    dynamic "ingress" {
        for_each = ["80", "8080"]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

       ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-http"
    }
}