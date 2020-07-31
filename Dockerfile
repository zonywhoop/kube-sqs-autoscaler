FROM golang:1.14-alpine3.12 as build

WORKDIR /go/src/kube-sqs-autoscaler

COPY . .
ENV GOOS=linux
RUN go build . \
    && ls -l

FROM alpine:3.12

COPY --from=build /go/src/kube-sqs-autoscaler/kube-sqs-autoscaler /

RUN  apk add --no-cache --update ca-certificates \
    && chmod 755 /kube-sqs-autoscaler

CMD ["/kube-sqs-autoscaler"]
