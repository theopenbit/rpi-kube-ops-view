FROM nventiveux/docker-alpine-rpi:3.5
MAINTAINER theOpenbit <tob at schoenesnetz.de>

EXPOSE 8080
RUN apk add --no-cache python3 python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev ca-certificates 

RUN apk add --no-cache python3 python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev ca-certificates && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools gevent && \
    apk del python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev 
    #&& \
    #rm -rf /var/cache/apk/* /root/.cache /tmp/* 
RUN apk add --no-cache git

RUN git clone -b 'v0.7' --single-branch --depth 1 https://github.com/hjacobs/kube-ops-view.git  kube_ops_view
RUN pip3 install -r /kube_ops_view/requirements.txt



ARG VERSION=dev
RUN sed -i "s/__version__ = .*/__version__ = '${VERSION}'/" /kube_ops_view/__init__.py

WORKDIR /
ENTRYPOINT ["/usr/bin/python3", "-m", "kube_ops_view"]

