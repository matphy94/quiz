echo "0 9 * * 1-5 ./script/cluster_deploy.sh" >> clustercron
echo "0 18 * * 1-5 ./script/cluster_destroy.sh" >> clustercron
crontab clustercron
rm clustercron
