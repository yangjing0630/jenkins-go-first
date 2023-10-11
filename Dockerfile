
#golang 基础镜像
FROM golang:rc-alpine3.15 AS build-env
RUN apk add git
ENV TIME_ZONE Asia/Shanghai

ENV GO111MODULE="on" \
    GOPROXY="https://goproxy.cn,direct"

WORKDIR /root/jenkins-go-first
#ADD <src> <dst>
ADD . .

RUN  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
     && GOSUMDB="off" \
#    && GOPROXY="https://goproxy.cn,direct" \
     && go mod download \
     && go build -o hello

#alpine 基础镜像
FROM alpine:3.15.0

ENV TIME_ZONE Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update \
 && apk upgrade \
 && apk add dumb-init

RUN echo "${TIME_ZONE}" > /etc/timezone \
 && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

WORKDIR /app
COPY --from=build-env /root/jenkins-go-first/hello /app/
COPY --from=build-env /root/jenkins-go-first/start.sh /app/

RUN chmod +x /app/hello
RUN chmod +x /app/start.sh

EXPOSE 9002
