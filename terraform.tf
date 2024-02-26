provider "aws" {
  region = "us-east-1"
  access_key = "AKI******" # Add your access_key
  secret_key = "umENEm***************" # Add your secret key
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
}

output "public_ip" {
  value = aws_instance.flask_api_instance.public_ip
}
