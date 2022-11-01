# Sends your public key to the instance
resource "aws_key_pair" "k8s" {
  key_name   = "k8s"
  public_key = file(var.PUBLIC_KEY_PATH)
}
