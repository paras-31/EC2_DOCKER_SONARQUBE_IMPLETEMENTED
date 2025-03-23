locals {
  user_data = <<-EOT
    #!/bin/bash
    sudo su
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    . ~/.nvm/nvm.sh
    nvm install 16
  EOT
}


# resource "aws_instance" "example" {
#   provider = aws.ap-south-1
#   count = 2
#   ami                          = "ami-074f77adfeee318d3" # Amazon Linux 2 AMI ID
#   instance_type                = "t2.micro"
#   subnet_id                    = "subnet-0b3fd8cdc676642fb"
#   user_data_base64            = base64encode(local.user_data)
#   user_data_replace_on_change = true
 
#   associate_public_ip_address = true
#   tags = {
#     Name = "instance${count.index + 1}"
#   }
# }



resource "aws_instance" "example1" {
  # provider = aws.us-east-1
  count = 2
  ami           = "ami-0e35ddab05955cf57" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  subnet_id = "subnet-09649994b79a181c2"
 # Use the appropriate subnet
  user_data     = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install docker.io -y 
              sudo usermod -aG docker $USER
              newgrp docker
              sudo chmod 777 /var/run/docker.sock
              git clone https://github.com/N4si/DevSecOps-Project.git
              cd DevSecOps-Project
              docker build -t netflix .
              docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
              EOF
  associate_public_ip_address = true # Associates a public IPv4 address

  tags = {
    Name = "instance${count.index + 1}"
  }   
}

