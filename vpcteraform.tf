# Create VPC
resource "aws_vpc" "Devvpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

tags = {
    Name = "Devvpc"

} 
}

# Create an Internet gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.Devvpc.id

    tags = {
        Name = "igw"
    
    }
}

# Create Public Subnet
resource "aws_subnet" "publics" {
    cidr_block = "10.0.1.0/24"
vpc_id = aws_vpc.Devvpc.id
    tags = {
        Name = "publics1"
    }
}

# Create Private Subnet
resource  "aws_subnet" "privates" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.Devvpc.id

    tags = {
        Name = "privates1"
    }
}

# Create eip
resource "aws_eip" "EIP" {
}
    resource "aws_nat_gateway" "NATgw" {
    allocation_id = aws_eip.EIP.id
    subnet_id = aws_subnet.publics.id

    tags = {
        Name = "EIP"

    }
    }


# Create Public Route Table
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.Devvpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id

    
    }
    }


# Create Private Route Table
resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.Devvpc.id

    route {
      
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATgw.id

    
}
}

# Associate Public subnet to Public Route table
resource "aws_route_table_association" "publics-route-public-rt" {
    subnet_id = aws_subnet.publics.id
    route_table_id =  aws_route_table.public-rt.id
}


# Associate Private Subnet to private route table
resource "aws_route_table_association" "privates-route-private-rt" {
    subnet_id = aws_subnet.privates.id
    route_table_id = aws_route_table.private-rt.id
    
}

  

