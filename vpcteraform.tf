# Create a VPC
resource "aws_vpc" "vpcname" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "testvpc"
  }
}


# create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpcname.id

  tags = {
    Name = "VPC IG1"
  }
}

# create a Public subnet 1
data "aws_subnet" "public-sb1" {
  vpc_id = aws_vpc.vpcname.id
  cidr_block = "${var.publicsb1}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "publicsb1"
  }
}

#Create a private subnet 1
data "aws_subnet" "private-sb1" {
  vpc_id = aws_vpc.vpcname.id
  cidr_block = "${var.privatesb1}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "privatesb1"
  }
}

#Create a routing table public
resource "aws_route_table" "pu-rt1" {
  vpc_id = aws_vpc.vpcname.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }

  

  tags = {
    Name = "public round table rt1"
  }
}




#Associate public subnet 1 to public route table

resource "aws_route_table_association" "publicsb1-route-pu-rt1" {
  subnet_id      = aws_subnet.public-sb1.id
  route_table_id = aws_route_table.pu-rt1.id
}

#Associate private subnet 1 to private route table

resource "aws_route_table_association" "publicsb1-route-pu-rt1" {
  subnet_id      = aws_subnet.public-sb1.id
  route_table_id = aws_route_table.pu-rt1.id
}

