FROM amazon/aws-cli
RUN aws configure set aws_access_key_id AKIAT3CW43W2B2FTAOXP
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
RUN kubectl apply -f deployment.yaml
RUN kubectl apply -f service.yaml
RUN kubectl get services
RUN kubectl get pods -o wide
RUN kubectl get nodes -o wide

