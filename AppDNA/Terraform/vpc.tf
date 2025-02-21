################
##### VPC  #####
################


resource "aws_vpc" "vpc_01" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "central-network-mdalbes"
    Owner = "mdalbes"
  }
}

resource "aws_cloudwatch_log_group" "flowlog_loggroup" {
  name = "loggroup-mdalbes"
}

resource "aws_flow_log" "prisma_flow_log" {
  log_destination      = aws_s3_bucket.flowlog-s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc_01.id
}

resource "aws_s3_bucket" "flowlog-s3" {
  bucket = "mdalbes-flowlogs"

  tags = {
    Name        = "mdalbes-flowlogs"
  }
}












