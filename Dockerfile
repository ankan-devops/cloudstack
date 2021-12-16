FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install docker -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN aws configure set aws_access_key_id AKIAUWPUR4LTZZRRSOX2
RUN aws configure set aws_secret_access_key 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
RUN aws configure set default.region ap-southeast-1
RUN aws configure set default.output json
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/bin/kubectl
#RUN mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
RUN aws eks --region ap-southeast-1 update-kubeconfig --name EKS-Demo-Cluster
COPY deployment.yaml .
COPY service.yaml .
RUN aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 323172295399.dkr.ecr.ap-southeast-1.amazonaws.com
RUN kubectl apply -f deployment.yaml
RUN kubectl apply -f service.yaml
RUN kubectl get services
RUN kubectl get pods -o wide
RUN kubectl get nodes -o wide

