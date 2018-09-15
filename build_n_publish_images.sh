account_id=1111111111111111111
region=us-east-1

image=$(echo $1 | cut -d ':' -f1)
tag=$(echo $1 | cut -d ':' -f2)


echo "docker build -t $image ."

echo "docker tag $image:$tag $account_id.dkr.ecr.$region.amazonaws.com/$image:$tag"

echo "docker push $account_id.dkr.ecr.$region.amazonaws.com/$image:$tag"

# Install Heptio Authenticator
# curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws
# chmod +x ./heptio-authenticator-aws && sudo mv heptio-authenticator-aws /usr/local/bin/
#
#
# ## instalando kops pra discover de DNS entre as maquinas e etc apenas uma vez
# wget https://github.com/kubernetes/kops/releases/download/1.10.0/kops-linux-amd64
# chmod +x kops-linux-amd64
# mv kops-linux-amd64 /usr/local/bin/kops
#
# # Create SSH key
# ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
# # Create EC2 Keypair apenas 1x
# aws ec2 create-key-pair --key-name t-microservices-eks --query 'KeyMaterial' --output text > ~/.ssh/k8s-workshop.pem
# chmod 0400 ~/.ssh/k8s-workshop.pem
#
# #####
# ## variaveis para usar o EKS
# ####
#
# export EKS_SERVICE_ROLE=arn:aws:iam::$account_id:role/k8s-workshop-EksServiceRo-AWSServiceRoleForAmazonE-14SWCFKBPDNLM && \
# export EKS_SUBNET_IDS=subnet-0ec600fab77e41271,subnet-0abf73a9d37714e0d && \
# export EKS_SECURITY_GROUPS=sg-034139231aa2d6a60 && \
# export EKS_VALID_AZS=us-east-1a,us-east-1b && \
# export EKS_VPC_ID=vpc-04fd55eef87a0849c && \
# export EKS_WORKER_AMI=ami-dea4d5a1
#
#
# # Download kubeconfig template
# mkdir ~/.kube && \
# aws s3 cp s3://aws-kubernetes-artifacts/v0.5/config-k8s-workshop ~/.kube/config
#
# # Configure based on EKS cluster k8s-workshop
# sed -i -e "s#<endpoint-url>#$(aws eks describe-cluster --profile maiquel --name t-microservices-eks --query cluster.endpoint --output text)#g" ~/.kube/config && \
# sed -i -e "s#<base64-encoded-ca-cert>#$(aws eks describe-cluster --profile maiquel --name t-microservices-eks --query cluster.certificateAuthority.data --output text)#g" ~/.kube/config && \
# sed -i -e "s#<cluster-name>#t-microservices-eks#g" ~/.kube/config && \
# sed -i -e "s#<role-arn>#$EKS_SERVICE_ROLE#g" ~/.kube/config
#
#
# aws cloudformation create-stack \
#   --stack-name k8s-workshop-worker-nodes \
#   --template-url https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/amazon-eks-nodegroup.yaml \
#   --capabilities CAPABILITY_IAM \
#   --parameters "[{\"ParameterKey\": \"KeyName\", \"ParameterValue\": \"t-microservices-eks\"},
#                  {\"ParameterKey\": \"NodeImageId\", \"ParameterValue\": \"${EKS_WORKER_AMI}\"},
#                  {\"ParameterKey\": \"ClusterName\", \"ParameterValue\": \"k8s-workshop\"},
#                  {\"ParameterKey\": \"NodeGroupName\", \"ParameterValue\": \"k8s-workshop-nodegroup\"},
#                  {\"ParameterKey\": \"ClusterControlPlaneSecurityGroup\", \"ParameterValue\": \"${EKS_SECURITY_GROUPS}\"},
#                  {\"ParameterKey\": \"VpcId\", \"ParameterValue\": \"${EKS_VPC_ID}\"},
#                  {\"ParameterKey\": \"Subnets\", \"ParameterValue\": \"${EKS_SUBNET_IDS}\"}]" --profile maiquel
#
# curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/aws-auth-cm.yaml
# export EKS_WORKER_ROLE=arn:aws:iam::$account_id:role/k8s-workshop-worker-nodes-NodeInstanceRole-1FV5NCC8JQVG0
# sed -i -e "s#<ARN of instance role (not instance profile)>#${EKS_WORKER_ROLE}#g" aws-auth-cm.yaml
# kubectl apply -f aws-auth-cm.yaml
