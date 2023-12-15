FROM golang:1.21 as build

WORKDIR /server

COPY go.mod go.sum ./
RUN go mod download

COPY protobuf/*.go protobuf/
COPY src/*.go src/

RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/server src/main.go

FROM alpine
COPY --from=build /bin/server /bin/server
EXPOSE 1353
CMD ["/bin/server"]
