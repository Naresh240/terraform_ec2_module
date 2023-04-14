resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  security_groups = ["${aws_security_group.allow_ssh.name}"]

  tags = {
    Name = "HelloWorld1"
  }

  depends_on  = [aws_security_group.allow_ssh]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic to connect linux"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}