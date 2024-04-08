# PROJECT_NAME

<insert description here>

## 🏁 Getting Started

```bash
...
```

## 🚀 Usage

_Update with output of --help_

## 📓 Examples

_Update with some examples_

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
