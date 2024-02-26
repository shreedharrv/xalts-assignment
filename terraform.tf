provider "aws" {
  region = "us-east-1"
  access_key = "AKIA4DPPPJ2USRGQBANW"
  secret_key = "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"
}

resource "aws_security_group" "flask_api_sg" {
  name        = "flask-api-sg"
  description = "Security group for Flask API"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "flask_api_instance" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t2.micro" 
  security_groups = [aws_security_group.flask_api_sg.name]

  tags = {
    Name = "flask-api-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo usermod -aG docker ubuntu
              sudo docker run -d -p 5000:5000 sid75747docker/flask-api:latest
              EOF

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/your-keypair.pem")  # Set the path to your private key
    host        = self.public_ip
  }
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.flask_api_instance.public_ip
}
