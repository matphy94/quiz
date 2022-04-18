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
cd ./terraform/
./cluster_deploy.sh
./cluster_destroy.sh

```

---

Schedule deploy cluster task
```
echo "0 9 * * 1-5 ./cluster_deploy.sh" >> clustercron
echo "0 18 * * 1-5 ./cluster_destroy.sh" >> clustercron
crontab clustercron
rm clustercron
```

---

Consider use below code to get CLB's external IP
```
echo kubectl -n hello-world get svc hello-world-2 -o jsonpath='{.status.loadBalancer.ingress[*].hostname}'
```
