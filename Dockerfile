FROM golang:1.23.4-alpine3.21 AS build
COPY main.go .
RUN go build -ldflags="-s -w" -o /app main.go


FROM scratch
COPY --from=build /app /app
CMD ["/app"]