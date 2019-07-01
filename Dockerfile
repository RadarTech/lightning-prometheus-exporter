FROM golang:1.12 as builder

ARG VERSION
ARG GIT_COMMIT

WORKDIR /usr/local/src/

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-X main.version=${VERSION} -X main.gitCommit=${GIT_COMMIT}" -o exporter .

FROM alpine:latest

RUN apk update && apk add ca-certificates

COPY --from=builder /usr/local/src/exporter /usr/bin/

ENTRYPOINT [ "/usr/bin/exporter" ]
