# Amazon Llinux 2 
data "aws_ami" "amazon_linux_2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "aws_availability_zones" "availabe" {
  state = "available"
}
