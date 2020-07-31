FROM golang:1.14 as build

WORKDIR /go/src/kube-sqs-autoscaler

COPY . .

RUN go build .

FROM alpine:3.4

COPY --from=build /go/src/kube-sqs-autoscaler/kube-sqs-autoscaler /

RUN  apk add --no-cache --update ca-certificates \
    & chmod 755 /kube-sqs-autoscaler

CMD ["/kube-sqs-autoscaler"]
