kubectl apply -f pod-admin-csr.yaml
kubectl get csr

kubectl certificate approve pod-admin

echo "waiting ...."

sleep 20

kubectl apply -f pod-admin-role.yaml

kubectl get roles -n project

kubectl apply -f pod-admin-roleBinding.yaml

kubectl get rolebindings -n project

kubectl describe rolebinding pod-admin-role-rolebinding -n project

kubectl auth can-i list pods --as pod-admin -n project

kubectl auth can-i create pods --as pod-admin -n project
