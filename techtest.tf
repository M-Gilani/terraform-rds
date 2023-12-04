provider "aws" {
  region = "us-west-2" # The region I picked. 
}

resource "aws_vpc" "dbase_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.dbase_vpc.id
  cidr_block        = "10.0.1.0/24"  
  availability_zone = "us-west-2a" # Public subnet in AZ us-west-2a
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.dbase_vpc.id
  cidr_block        = "10.0.2.0/24" # Private subnet 1 in AZ us-west-2b
  availability_zone = "us-west-2b"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.dbase_vpc.id
  cidr_block        = "10.0.3.0/24" # Private subnet 2 in AZ us-west-2c
  availability_zone = "us-west-2c"
}

resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = "example-db-subnet-group"  # Adjusted subnet group name
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

resource "aws_security_group" "rds_security_group" {
  vpc_id = aws_vpc.dbase_vpc.id

  # Allow inbound access only from within the VPC
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.dbase_vpc.cidr_block]
  }
}

resource "aws_db_instance" "ecomrds" {
  allocated_storage      = 200
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.m5.large"
  identifier             = "example-db"
  username               = "ecomdbase"
  password               = "yellowtub"  # For testing purposes only. Avoid storing passwords in plain text in production.
  db_subnet_group_name   = aws_db_subnet_group.example_db_subnet_group.name 
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  multi_az               = true # so it is highly available
  storage_encrypted      = true # so it is even more secure
  backup_retention_period = 7 
}

