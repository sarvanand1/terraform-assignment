# VPC Creation

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

# AWS Public Subnet

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr_block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public_subnet_${count.index}"
  }
}

# AWS Private Subnet

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr_block)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private_subnet_${count.index}"
  }
}

# AWS Internet Gateway

resource "aws_internet_gateway" "igway" {
  vpc_id = aws_vpc.main.id
}

# AWS EIP Gateway

resource "aws_eip" "nat_eip" {
  vpc = true
}


# AWS NAT Gateway

resource "aws_nat_gateway" "ngway" {
  subnet_id     = element(aws_subnet.public_subnet.*.id, 1)
  allocation_id = aws_eip.nat_eip.id
  depends_on    = [aws_internet_gateway.igway]
}

# AWS Private Route Table


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngway.id
  }
}

# AWS Private Route Table Association

resource "aws_route_table_association" "associate-private" {
  count = length(aws_subnet.private_subnet.*.id)

  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
}

# AWS Public Route Table

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igway.id
  }
}

# AWS Public Route Table Association

resource "aws_route_table_association" "associate-public" {
  count = length(aws_subnet.public_subnet.*.id)

  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}

# AWS Security Group Rule

resource "aws_security_group" "allow_tls" {
  name        = "inbound_tls"
  description = "AWS security group for EC2 instance and RDS"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    #      cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS DB Subnet Group

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_subnet_group"
  description = "Group of DB subnets"

  #  count = "${length(aws_subnet.private_subnet.*.id)}"
  subnet_ids = aws_subnet.private_subnet.*.id

}

