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

-   Run tf command with correct image id
        terraform apply -var packer_image=ami-0fbb55262cc968102 --auto-approve

