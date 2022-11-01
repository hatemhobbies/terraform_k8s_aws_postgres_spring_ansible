variable "worker_ips" {
  type = list(string)

  default = [
    "10.240.0.20",
    "10.240.0.21"
  ]
}