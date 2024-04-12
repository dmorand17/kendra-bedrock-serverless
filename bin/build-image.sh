#!/bin/bash

set -uo pipefail

command -v docker >/dev/null 2>&1 || { echo "Docker required!  Aborting." >&2; exit 1; }

AWS_REGION=${AWS_REGION:-AWS_DEFAULT_REGION}
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO=kendra-bedrock-serverless

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

$(command -v docker) buildx inspect default &> /dev/null
if [[ $? -eq 0 ]]; then
  DOCKER_BUILD_BIN="$(command -v docker) buildx build"
else
  DOCKER_BUILD_BIN="$(command -v docker) build"
fi

$DOCKER_BUILD_BIN \
  --platform linux/amd64 \
  . -t $ECR_REPO:latest

docker tag $ECR_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest
