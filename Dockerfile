# 如果因网络原因不通,可以从:
# https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md 下载 Client
# https://github.com/helm/helm/releases 下载 helm
# 

FROM alpine

RUN apk add --update --no-cache ca-certificates curl wget bash \
 && wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz \
 && wget https://storage.googleapis.com/kubernetes-release/release/v1.13.3/kubernetes-client-linux-amd64.tar.gz \
 && tar -zxvf helm-v2.12.3-linux-amd64.tar.gz \
 && tar -zxvf kubernetes-client-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin/helm \
 && mv kubernetes/client/bin/kubectl /usr/local/bin/kubectl \
 && rm -f helm-v2.12.3-linux-amd64.tar.gz \
 && rm -f kubernetes-client-linux-amd64.tar.gz \
 && rm -rf linux-amd64 \
 && rm -rf kubernetes \
 && chmod +x /usr/local/bin/helm \
 && chmod +x /usr/local/bin/kubectl \
 && mkdir -p ~/.kube 

# 可自行初始化 helm repo
# RUN helm init --client-only --stable-repo-url http://charts.uniteidea.cn

# 可自行拷贝 kube config 文件以便能连接到 K8S 集群
# COPY kubeconfig /root/.kube/config

WORKDIR /project

ENTRYPOINT [ "/bin/bash" ]
