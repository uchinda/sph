#!/bin/bash

AmazonEKS_EFS_CSI_Driver_Policy_Check=$(aws iam list-policies | grep -i PolicyName | grep -i AmazonEKS_EFS_CSI_Driver_Policy)
EKS_Cluster_Name="sph-eks-cluster"
REGION="ap-southeast-1"
ACCOUNT_ID="954399971300"

# Check EFS CSI polcy exists
if [ -z "$AmazonEKS_EFS_CSI_Driver_Policy_Check" ]
then
    printf "\nEFS_CSI_Driver Policy not exists\nCreating Policy...\n"
    aws iam create-policy --policy-name AmazonEKS_EFS_CSI_Driver_Policy --policy-document file://iam-policy-efs-csi.json
else
    printf "\nAmazonEKS_EFS_CSI_Driver_Policy Exists..!!\n"

# Creat Service Account in EKS
printf "\nCreating \"efs-csi-controller-sa\" Service Account\n"

eksctl create iamserviceaccount \
    --name efs-csi-controller-sa \
    --namespace kube-system \
    --cluster ${EKS_Cluster_Name} \
    --attach-policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/AmazonEKS_EFS_CSI_Driver_Policy \
    --override-existing-serviceaccounts \
    --region ${REGION} \
    --approve

# Install the Amazon EFS driver

printf "\nInstalling the Amazon EFS driver on EKS...\n"
helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
helm repo update
helm upgrade -i aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver \
    --namespace kube-system \
    --set image.repository=602401143452.dkr.ecr.ap-southeast-1.amazonaws.com/eks/aws-efs-csi-driver \
    --set controller.serviceAccount.create=false \
    --set controller.serviceAccount.name=efs-csi-controller-sa

printf "\n\n Checking Status...\n"
kubectl get deployment -n kube-system efs-csi-controller