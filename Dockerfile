FROM golang:1.9.3 as build
ADD . /go/src/github.com/jgadling/consulfs/
WORKDIR /go/src/github.com/jgadling/consulfs/cmd/consulfs
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build

FROM ubuntu:bionic
RUN apt-get update && apt-get install -y fuse curl vim jq
COPY --from=build /go/src/github.com/jgadling/consulfs/cmd/consulfs/consulfs /bin/consulfs
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
