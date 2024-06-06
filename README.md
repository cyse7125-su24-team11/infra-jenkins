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


## Deploy Infrastructure

-   Get password from Jenkins - cat /var/lib/jenkins/secrets/initialAdminPassword
-   Run tf command with correct image id
        terraform apply -var packer_image=ami-0ce1264861c0124a0 --auto-approve
-   terraform destroy --auto-approve  

-       kubectl create secret docker-registry regcred --docker-server=[https://index.docker.io/v1/]--docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>


kubectl create secret generic regcred --from-file=.dockerconfigjson=/Users/shabinasingh/.docker/config.json --type=kubernetes.io/dockerconfigjson
