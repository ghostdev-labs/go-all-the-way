FROM golang:1.19-alpine3.17 AS builder

WORKDIR /go-all-the-way-develop

COPY . .

COPY go.mod ./

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Path: Dockerfile
FROM alpine:3.17

WORKDIR /root/

COPY --from=builder /go-all-the-way/main .

EXPOSE 8080

CMD ["./main"]
