FROM golang:1.24 AS build
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

FROM alpine:latest AS final
WORKDIR /app
COPY --from=build /app/main .
ENTRYPOINT ["/app/main"]
EXPOSE 8080