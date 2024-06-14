provider "aws" {
  region = "us-east-1"
}

# Added network resources for Jenkins
#
#

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  depends_on = [aws_vpc.vpc]
  tags = {
    Name = var.public_subnet_name
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_block
  depends_on = [aws_vpc.vpc]
  tags = {
    Name = var.private_subnet_name
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.internet_gw
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.internet_gateway
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.route_table_name
  }
	depends_on = [ aws_internet_gateway.gw ]
}
resource "aws_route_table_association" "make_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
	depends_on = [ aws_subnet.public_subnet, aws_route_table.route_table ]
}
resource "aws_security_group" "sg" {
  name        = var.sg_name
  vpc_id      = aws_vpc.vpc.id

	ingress {
    protocol    = var.tcp_protocol
		cidr_blocks = [var.internet_gateway]
		from_port   = var.ssh_default_port
		to_port     = var.ssh_default_port
	}	
  ingress {
    protocol    = var.tcp_protocol
		cidr_blocks = [var.internet_gateway]
		from_port   = var.https_default_port
		to_port     = var.https_default_port
	}
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.internet_gateway]
  }
  ingress {
    from_port   = var.app_default_port
    to_port     = var.app_default_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.internet_gateway]
  }
	egress {
		from_port         = var.https_default_port
		to_port           = var.https_default_port
		protocol          = var.tcp_protocol
		cidr_blocks = [var.internet_gateway]
	}
	egress {
		from_port         = var.app_port
		to_port           = var.app_port
		protocol          = var.tcp_protocol
		cidr_blocks = [var.internet_gateway]
	}	
	egress {
		from_port         = var.app_default_port
		to_port           = var.app_default_port
		protocol          = var.tcp_protocol
		cidr_blocks = [var.internet_gateway]
	}
  tags = {
    Name = var.sg_name
  }
  depends_on = [aws_vpc.vpc]

}

# Added EC2 Server and Configuration for Jenkins
#
#

resource "aws_instance" "jenkins_ec2" {
  ami           = var.packer_image # Replace with your AMI ID
  instance_type = var.jenkins_ec2_instance_type
  subnet_id     = aws_subnet.public_subnet.id

  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = var.jenkins_ec2
  }

  user_data = <<-EOF
              #!/bin/bash

              # Restart Caddy with custom Caddyfile  
              sudo chmod 755 /etc/caddy/Caddyfile
              sudo systemctl restart caddy
              sudo systemctl status caddy --no-pager

              # Restart Jenkins to apply the plugins
              sudo systemctl restart jenkins
              EOF
	depends_on = [ aws_subnet.public_subnet, aws_security_group.sg ]
    root_block_device {
    volume_size = 50
    volume_type = "gp2"

  }
}


data "aws_eip" "eip" {
  filter {
    name   = var.eip_tag
    values = [var.jenkins_ec2]
  }
}

resource "aws_eip_association" "jenkins_eip_assoc" {
  instance_id   = aws_instance.jenkins_ec2.id
  allocation_id = data.aws_eip.eip.id
	depends_on = [ aws_instance.jenkins_ec2 ]
}