resource "aws_instance" "k8s_controller" {
  depends_on                  = [aws_vpc.k8s]
  ami                         = "${data.aws_ami.ubuntu.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.k8s.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.k8s.id}"]
  instance_type               = "t2.micro"
  private_ip                  = "${var.controller_ip}"
  user_data                   = "name=k8s_controller"
  subnet_id                   = "${aws_subnet.k8s.id}"
  source_dest_check           = false

  tags = {
    Name = "k8s_controller"
  }

  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      user = "ubuntu"
      private_key = file("~/.ssh/k8s_rsa")
    }
    inline = ["echo 'Instance ${self.public_dns} is up!'"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -T 300 -i '${self.public_ip},' --extra-vars 'private_ip=${self.private_ip} hostname=${split(".", self.private_dns)[0]} public_ip=${self.public_ip}' --private-key ~/.ssh/k8s_rsa ../ansible/k8s_controller_playbook.yml"
  }
}
