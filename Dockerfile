FROM golang:latest AS builder
RUN go get github.com/8ayac/fizzbuzzHTTPserver
WORKDIR /go/src/github.com/8ayac/fizzbuzzHTTPserver
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o fizzbuzz main.go

FROM scratch
WORKDIR /fizzbuzz
COPY --from=builder /go/src/github.com/8ayac/fizzbuzzHTTPserver/fizzbuzz .
ENTRYPOINT ["/fizzbuzz"]
