resource "aws_key_pair" "main" {
  key_name   = "Terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  name        = "main"
  description = "this is a security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_instance" "main" {
  depends_on = [ null_resource.main ]                         //explicit dependency --> depens_on
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]         //implicit dependency --> security group, when a resourse references another resources's attribute
  key_name               = aws_key_pair.main.id

  provisioner "file" {
    source      = "/Users/ianaskidanova/github/terraform-session/session-8/index.html" //local path, th w path where your file exist, local machine
    destination = "/tmp/index.html"                                                    // remote path . the path where you send file to
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }
  }

}

resource "null_resource" "main" {
  provisioner "local-exec" {
    command = "echo 'Testing local exec' > index.html"
  }
}