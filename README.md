# quiz


Requirements
| Name          | Version|
|-------------:| ------:|
|terraform| 0.13.1|
|aws| >= 3.72|
|kubernetes| >= 2.10|

---

Basic Usage
```
terraform plan -out quiz
terraform apply quiz
```

---

Consider use below code to get CLB's external IP
```
echo kubectl -n hello-world get svc hello-world-2 -o jsonpath='{.status.loadBalancer.ingress[*].hostname}'
```
