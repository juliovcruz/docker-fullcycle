FROM golang:1.15.8-alpine3.13 AS builder

WORKDIR /go/src/api
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build -ldflags '-w -s' -o main main.go

FROM scratch
COPY --from=builder /go/src/api/main .
EXPOSE 3000
CMD [ "./main" ]