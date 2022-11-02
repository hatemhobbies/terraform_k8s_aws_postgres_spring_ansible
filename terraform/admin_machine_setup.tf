resource "null_resource" "fetch_kubeconfig" {
  depends_on                  = [aws_instance.k8s_worker]
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ~/.kube
      scp -i ~/.ssh/k8s_rsa ubuntu@${aws_instance.k8s_controller.public_ip}:~/.kube/config ~/.kube/config
      sed 's/server: .*$/server: https:\/\/${aws_instance.k8s_controller.public_ip}:6443/g' ~/.kube/config > ~/.kube/config.tmp && mv -f ~/.kube/config.tmp ~/.kube/config

    EOT
  }
}

