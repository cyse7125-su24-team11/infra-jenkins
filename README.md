# infra-jenkins


## Infrastructure as Code for Jenkins
Added the following resources for to host Jenkins -
-   VPC
-   Public Subnet
-   Security Group
-   Internet Gateway
-   Route Table
-   Route Table Association
-   EC2 Instance
-   EIP Association


## Deploy Jenkins Infrastructure

-   Trigger Jenkins AMI build from github
-   Deploy infrastructure for Jenkins using AMI 
-   Run tf command with correct image id
        terraform apply -var packer_image=ami-0ce1264861c0124a0 --auto-approve
-   Get password from Jenkins EC2 - cat /var/lib/jenkins/secrets/initialAdminPassword
-   Add credentials' password for Github and Docker Registery into Jenkins 
-   Trigger build to push docker image
-   Optional - terraform destroy --auto-approve  

-   Deploy Kubernetes infrastructure
-   kind create cluster
-   kubectl apply -f configmap.yaml
-   kubectl apply -f secret.yaml
-   kubectl apply -f pod.yaml
-   kubectl apply -f service.yaml

-       kubectl create secret docker-registry regcred --docker-server=[https://index.docker.io/v1/]--docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
-       kubectl create secret generic regcred --from-file=.dockerconfigjson=/Users/shabinasingh/.docker/config.json --type=kubernetes.io/dockerconfigjson
