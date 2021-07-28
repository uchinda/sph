#!/bin/bash

AWSLoadBalancerControllerIAMPolicyCheck=$(aws iam list-policies | grep -i PolicyName | grep -i AWSLoadBalancerControllerIAMPolicy)
EKS_Cluster_Name="sph-eks-cluster"
REGION="ap-southeast-1"
ACCOUNT_ID="954399971300"

# Check AWSLoadBalancerControllerIAMPolicy Exists
if [ -z "$AWSLoadBalancerControllerIAMPolicyCheck" ]
then
    printf "\nAWSLoadBalancerControllerIAM Policy not Exists..!!!\nCreating Policy....\n"
    aws iam create-policy \
        --policy-name AWSLoadBalancerControllerIAMPolicy \
        --policy-document file://iam_policy_alb.json
else
    printf "\nAWSLoadBalancerControllerIAMPolicy Exists..!\n"

# Creating Service Account
printf "\n\n"

eksctl create iamserviceaccount \
    --cluster=${EKS_Cluster_Name} \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --region ${REGION} \
    --approve

# Install AWSLoadBalancerController
printf "\nInstalling AWS LoadBalancer Controller on EKS...\n\nInstalling the TargetGroupBinding custom resource definitions\n"
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

printf "\nAdding Helm Charts\n"
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=${EKS_Cluster_Name} \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller \
    --region=${REGION} \
    -n kube-system

printf "\n\n Checking Status...\n"
kubectl get deployment -n kube-system aws-load-balancer-controller