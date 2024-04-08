# Kendra Bedrock Serverless App

This is a sample application to demonstrate how to deploy a python repository into Amazon ECS.

This example is based off the [amazon-kendra-langchain-extensions](https://github.com/aws-samples/amazon-kendra-langchain-extensions) repo

## Prerequisites

**Build requirements**

- AWS CLI with proper credentials
- Docker or equivalent container solution (e.g. [finch](https://github.com/runfinch))

**ECS deployment requirements**

- Kendra index
- VPC w/at least 2 private/public subnets

## 🏁 Getting Started

1/ Deploy [ecr-repository.yaml](ecr-repository.yaml) CloudFormation template to create ECR repository

2/ Build docker image and push image to ECR repo

```bash
./bin/build-image.sh
```

3/ Deploy [ecs-cluster.yaml](ecs-cluster.yaml) CloudFormation template to create the ECS service

4/ Once deployed open the `Outputs` tab of the CloudFormation deployment and open the `ApplicationLoadBalancer` url.

## 🛠️ Development

Build docker container

```bash
docker build . -t kendra-bedrock-serverless:latest
```

## 🧪 Testing locally

Testing image locally

```bash
KENDRA_INDEX=<INSERT_KENDRA_INDEX_ID>
docker run -rm \
  -v ~/.aws:/root/.aws
  -e AWS_REGION='us-east-1' \
  -e KENDRA_INDEX_ID=$KENDRA_INDEX \
  -p 8000:8080 \
  kendra-bedrock-serverless:latest
```

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
