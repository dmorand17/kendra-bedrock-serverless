#!/bin/bash

set -uo pipefail

AWS_REGION=${AWS_REGION:-AWS_DEFAULT_REGION}
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO=kendra-bedrock-serverless

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

DOCKER_BIN="$(command -v finch) build"
if [[ $? -ne 0 ]]; then
  echo "finch not found, trying docker"
  DOCKER_BIN="$(command -v docker) buildx build"
fi

$DOCKER_BIN \
  --platform linux/amd64 \
  . -t $ECR_REPO:latest

docker tag $ECR_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO
