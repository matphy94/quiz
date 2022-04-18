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
echo "0 9 * * 1-5 ./script/cluster_deploy.sh" >> clustercron
echo "0 18 * * 1-5 ./script/cluster_destroy.sh" >> clustercron
crontab clustercron
rm clustercron
```

---

Consider use below code to get CLB's external IP
```
echo kubectl -n hello-world get svc hello-world-2 -o jsonpath='{.status.loadBalancer.ingress[*].hostname}'
```
---
Step by Step explaination

Scenario:
Include a script to destroy the cluster and also provide steps to deploy scheduler it to run at a predefined time of day.

## I am assuming that we will need a script to deploy the resources every day in 9pm and
a script to destroy the resources every day in 6pm for developer to work during the working hour,
So we will have 2 scripts scheduled to run every weekday. ##
------------------------------------------------------------------
1) Please clone the repository
2) Please go into **terraform** directory and run
```
./cluster_deploy.sh
```
It will use terraform and deploy the cluster. Once the cluster is deployed, then in28min/hello-world-rest-api 0.0.1 RELEASE will be deployed on it
The service is exposed with loadbalancer and will be scaled based on CPU usage > 80% , with 2 instances minimum and 5 instances maximum.
3) Please run if you want to destroy the cluster, it will delete deployment/services etc on the cluster.
```
./cluster_destroy.sh
```
4) Please go into **script** directory and run scheduler.sh for scheduler deployment
```
cd ../script
./scheduler.sh
```
You may have to adjust the PATH in scheduler.sh
It will create cronjob, while deploy the cluster on every weekday at 9am, and destroy the cluster on every weekday 6pm.
Nothing happened on Saturday and Sunday.
