kubectl delete hpa hello-world-2 -n hello-world
kubectl delete services hello-world-2 -n hello-world
kubectl delete deployments hello-world-2 -n hello-world
sleep 30
terraform destroy -auto-approve