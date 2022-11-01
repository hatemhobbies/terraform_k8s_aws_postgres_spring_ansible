resource "aws_vpc" "k8s" {
  cidr_block           = "10.240.0.0/24"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "kubernetes-simplilearn"
  }
}

resource "aws_vpc_dhcp_options" "k8s" {
  domain_name         = "us-east-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s" {
  vpc_id          = "${aws_vpc.k8s.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.k8s.id}"
}

resource "aws_subnet" "k8s" {
  vpc_id     = "${aws_vpc.k8s.id}"
  cidr_block = "10.240.0.0/24"

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_internet_gateway" "k8s" {
  vpc_id = "${aws_vpc.k8s.id}"

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route_table" "k8s" {
  vpc_id = "${aws_vpc.k8s.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.k8s.id}"
  }

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route_table_association" "k8s" {
  subnet_id      = "${aws_subnet.k8s.id}"
  route_table_id = "${aws_route_table.k8s.id}"
}
