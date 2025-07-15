#!/bin/bash

echo "🔐 Enter your AWS credentials"

read -p "AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -s -p "AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
echo ""
read -p "AWS Region (default: us-east-1): " AWS_REGION

AWS_REGION=${AWS_REGION:-us-east-1}

# Configure AWS CLI
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set region "$AWS_REGION"

echo "✅ AWS CLI is configured!"
