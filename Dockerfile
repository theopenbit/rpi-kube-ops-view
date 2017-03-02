FROM hypriot/rpi-alpine:3.5
MAINTAINER theOpenbit <tob at schoenesnetz.de>

EXPOSE 8080


RUN apk add --no-cache git python3 python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev ca-certificates && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools gevent && \
    apk del python3-dev gcc musl-dev zlib-dev libffi-dev openssl-dev
    
#RUN rm -r /usr/lib/python*/ensurepip && \
#    rm -rf /var/cache/apk/* /root/.cache /tmp/* 

RUN git clone -b '0.7.1' --single-branch --depth 1 https://github.com/hjacobs/kube-ops-view.git  kube_ops_view
RUN pip3 install -r /kube_ops_view/requirements.txt




RUN sed -i "s/__version__ = .*/__version__ = 'dev'/" /kube_ops_view/kube_ops_view/__init__.py

WORKDIR /kube_ops_view
ENTRYPOINT ["/usr/bin/python3", "-m", "kube_ops_view"]

