FROM python:3.11-slim

ARG BRANCH=main

# Clone the GitHub repository
RUN apt-get update && apt-get install -yq unzip wget
RUN wget https://github.com/aws-samples/amazon-kendra-langchain-extensions/archive/refs/heads/${BRANCH}.zip \
  && unzip ${BRANCH}.zip 

# Install dependencies
WORKDIR /amazon-kendra-langchain-extensions-${BRANCH}/kendra_retriever_samples/
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port","8080"]
CMD ["bedrock_claudev2"]
