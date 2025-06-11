terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

data "aws_security_group" "apache_server" {
  name = "launch-wizard-1" # Replace with your SG name
}

data "aws_key_pair" "apache_server" {
  key_name = "Christos" # Replace with your key pair name
}

resource "aws_instance" "apache_server" {
  ami                    = "ami-0c7217cdde317cfec" # Amazon Linux 2023 AMI in us-east-1
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.apache_server.key_name
  vpc_security_group_ids = [data.aws_security_group.apache_server.id]
  user_data              = <<-EOF
              #!/bin/bash
              # Update package list and install Apache
              dnf update -y
              dnf install -y httpd

              # Start and enable Apache service
              systemctl start httpd
              systemctl enable httpd

              # Set permissions for Apache root directory
              chown -R ec2-user:ec2-user /var/www/html

              # Create a custom index.html page
              cat <<'EOHTML' > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Welcome to Emmanuel's Custom Apache Server</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          background-color: #f4f4f4;
                          text-align: center;
                          padding: 50px;
                      }
                      .container {
                          background: white;
                          padding: 20px;
                          border-radius: 10px;
                          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                          display: inline-block;
                      }
                      h1 {
                          color: #333;
                      }
                      p {
                          color: #666;
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>Welcome to My Emmanuel's Apache Web Server!</h1>
                      <p>Hosted on an Amazon Linux 2023 EC2 Instance.</p>
                      <p>This page was deployed automatically using AWS User Data.</p>
                  </div>
              </body>
              </html>
              EOHTML

              # Restart Apache to apply changes
              systemctl restart httpd
              EOF

  tags = {
    Name = "Custom-Apache-Web-Server"
  }
}

output "instance_public_ip" {
  value       = aws_instance.apache_server.public_ip
  description = "Public IP address of the EC2 instance"
}

output "website_url" {
  value       = "http://${aws_instance.apache_server.public_ip}"
  description = "URL to access the website"
}
