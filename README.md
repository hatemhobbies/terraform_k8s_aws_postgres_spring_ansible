# Java Spring, AWS, Kubernetes, docker, terraform and ansible Project
# terraform_k8s_aws_postgres_spring_ansible

Pre requisite (create a file aws_key.sh then chmod +x aws_key.sh and then source ./aws_key.sh) - of course use your credentials

#!/bin/sh
export AWS_ACCESS_KEY_ID=***************************************
export AWS_SECRET_ACCESS_KEY=****************************************
export AWS_REGION=us-east-2



1) You should have k8s_rsa and k8s_ras.pub in your ~/.ssh directory
2) git pull the project 
3) terraform init
4) terraform apply -auto-approve
5) When done
   terraform destroy -auto-approve 

