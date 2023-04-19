###################################
## Virtual Machine Module - Main ##
###################################

# Create Elastic IP for the EC2 instance
resource "aws_eip" "ec2_eip" {
  count    = var.settings.web_app.count
  instance = aws_instance.ec2_instance[count.index].id
  vpc      = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2-eip-${count.index}"
    Environment = var.app_environment
  }
}

# Define the security group for the Linux server
resource "aws_security_group" "ec2_sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-ec2-sg"
  description = "Allow incoming Instance connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2-sg"
    Environment = var.app_environment
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2_instance" {
  count                  = var.settings.web_app.count
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.settings.web_app.instance_type
  subnet_id              = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  user_data              = file("ec2_script.sh")
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2_intance-${count.index}"
    Environment = var.app_environment
  }

}
