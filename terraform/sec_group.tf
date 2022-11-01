
resource "aws_security_group" "k8s" {
  name        = "kubernetes"
  description = "Kubernetes security group"
  vpc_id      = "${aws_vpc.k8s.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.240.0.0/24", "10.200.0.0/16"]
  }

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
      from_port   = 0
      to_port     = 30000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  # May be wrong
  ingress {
    from_port   = 0
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # define the outbound rule, allow all kinds of accesses from anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubernetes"
  }
}