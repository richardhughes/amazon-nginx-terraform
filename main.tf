provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "live" {
  ami = "ami-6d263d09"
  instance_type = "t2.nano"
  key_name = "${var.aws_key_name}"

  tags {

  }

  vpc_security_group_ids = [
    "${aws_security_group.http-group.id}",
    "${aws_security_group.https-group.id}",
    "${aws_security_group.ssh-group.id}",
    "${aws_security_group.all-outbound-traffic.id}",
  ]
}

resource null_resource "ansible_web" {
  depends_on = [
    "aws_instance.live"
  ]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key '${var.aws_pem_location}' -i '${aws_instance.live.public_ip},' ansible/main.yml"
  }
}

resource "aws_security_group" "https-group" {
  name = "https-access-group"
  description = "Allow traffic on port 443 (HTTPS)"

  tags = {
    Name = "HTTPS Inbound Traffic Security Group"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


resource "aws_security_group" "http-group" {
  name = "http-access-group"
  description = "Allow traffic on port 80 (HTTP)"

  tags = {
    Name = "HTTP Inbound Traffic Security Group"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "all-outbound-traffic" {
  name = "all-outbound-traffic-group"
  description = "Allow traffic to leave the AWS instance"

  tags = {
    Name = "Outbound Traffic Security Group"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "ssh-group" {
  name = "ssh-access-group"
  description = "Allow traffic to port 22 (SSH)"

  tags = {
    Name = "SSH Access Security Group"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}