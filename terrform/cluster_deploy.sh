terraform init
terraform plan -out quiz
terraform apply quiz
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
kubectl create namespace hello-world
kubectl create deployment hello-world-2 --image=in28min/hello-world-rest-api:0.0.1.RELEASE -n hello-world
kubectl expose deployment hello-world-2 --type=LoadBalancer --port=80 --target-port=8080 -n hello-world
kubectl autoscale deployment hello-world-2 --min=2 --max=5 --cpu-percent=80 -n hello-world

#export loadbalancer=$(kubectl -n hello-world get svc hello-world-2 -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
#curl -k -s -I http://{$loadbalancer}  | grep '200'
#curl -k -s http://{$loadbalancer}/hello-world | grep '200'