#!/bin/bash

set -x

openssl genrsa -out  pod-admin.key 2048
openssl req -new -key pod-admin.key -out pod-admin.csr -subj "/CN=pod-admin/O=project"

# Replace the CSR in the csr.yaml
CSR=$(cat pod-admin.csr | base64 | tr -d '\n')
sed -i "s/__CSR___/${CSR}/g" pod-admin-csr.yaml
