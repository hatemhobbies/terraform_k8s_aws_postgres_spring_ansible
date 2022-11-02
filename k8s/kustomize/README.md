We use **Kustomize** to organize our k8s files.
Kustomize is a tool that helps us improve Kubernetes’ declarative object management with configuration files.

**Usage:**

**For deploying to the DEV environment:**
```sh
cd ../..
kubectl apply -k k8s/kustomize/dev
```

Notice the **-k**, which denotes usage of a Kustomize configuration
