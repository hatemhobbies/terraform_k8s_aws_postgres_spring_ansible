resource "aws_instance" "k8s_worker" {
  depends_on                  = [aws_instance.k8s_controller]
  count                       = "${length(var.worker_ips)}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.k8s.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.k8s.id}"]
  instance_type               = "t2.micro"
  private_ip                  = "${var.worker_ips[count.index]}"
  user_data                   = "name=k8s_worker-${count.index+1}|pod-cidr=${var.worker_pod_cidrs[count.index]}"
  subnet_id                   = "${aws_subnet.k8s.id}"
  source_dest_check           = false

  tags = {
    Name = "k8s_worker-${count.index+1}"
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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -T 300 -i '${self.public_ip},' --private-key ~/.ssh/k8s_rsa ../ansible/k8s_node_playbook.yml"
  }
}
