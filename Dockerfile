FROM alpine:latest
LABEL maintainer="egyardian99@gmail.com"


#exporting repos
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories
#install tools
RUN apk add --update --no-cache \
busybox-extras \
curl \
which \
bash \
openssl \
wget \
tar \
zip \
unzip \
traceroute \
redis \ 
postgresql-client \
mysql-client \
mongodb \
&& rm -rf /var/cache/apk/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv ./kubectl /usr/bin/kubectl

#install helmv2

RUN curl -LO https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.7.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf helm-v3.7.0-linux-amd64.tar.gz linux-amd64

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh

WORKDIR /

CMD ["sh", "-c", "tail -f /dev/null"]
