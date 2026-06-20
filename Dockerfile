FROM alpine:3.20

RUN apk add --no-cache wget tar && \
    addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

WORKDIR /app

COPY NOTICE.txt .

RUN wget https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \
    tar -zxvf sing-box-1.10.1-linux-amd64.tar.gz && \
    mv sing-box-1.10.1-linux-amd64/sing-box ./ && \
    rm -rf sing-box-1.10.1-linux-amd64*

COPY config.json .

USER appuser

EXPOSE 8080
CMD ["./sing-box", "run", "-c", "config.json"]
