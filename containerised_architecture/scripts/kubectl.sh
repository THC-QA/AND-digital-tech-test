curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
sudo echo 'export PATH=$PATH:$HOME/bin' >> sudo ~/.bashrc
sed -i 's/%certificate_arn%/$CERT_ARN/g' ./kube-serv/service-nginx.yaml
sed -i 's/%domain_name%/$DOMAIN_NAME/g' ./kube-serv/service-nginx.yaml
kubectl version --short --client
aws eks update-kubeconfig --name nginx
sleep 20
kubectl apply -f /var/lib/jenkins/workspace/ANDskillstest/kube-serv/service-nginx.yaml