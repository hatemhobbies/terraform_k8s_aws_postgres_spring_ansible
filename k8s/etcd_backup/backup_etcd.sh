#!/bin/bash

set -x

# Create temp fo
ETC_BACKUP_DIR=/tmp/etcd
[ -d ${ETC_BACKUP_DIR} ] || mkdir -p ${ETC_BACKUP_DIR}
cd ${ETC_BACKUP_DIR}

# Create snapshot
K8S_CERT_FOLDER=/etc/kubernetes/pki/etcd
sudo ETCDCTL_API=3 \
  etcdctl snapshot save snapshot.db   \
  --cacert ${K8S_CERT_FOLDER}/ca.crt     \
  --cert   ${K8S_CERT_FOLDER}/server.crt \
  --key    ${K8S_CERT_FOLDER}/server.key
