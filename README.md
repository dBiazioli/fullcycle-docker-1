# Full Cycle 3.0
## Desafio Docker - Go

Esse desafio consiste em publicar uma imagem no DockerHub para a linguagem Go. Ao executar:
```
docker run -rm dbiazioli/fullcycle
```
Deve ter o seguinte resultado: Full Cycle Rocks!!

Após compilada, a imagem deve ter menos de 2MB.

#### Pull 
```
docker pull dbiazioli/fullcycle
```

#### Execução
```
docker run --rm dbiazioli/fullcycle
```

## Dockerfile
O primeiro bloco é responsável por compilar o código e gerar o binário. O parametro `-ldflags="-s -w"` é responsável por remover informações de debug, reduzindo o tamanho final.
```dockerfile
FROM golang:1.23.4-alpine3.21 AS build
COPY main.go .
RUN go build -ldflags="-s -w" -o /app main.go
```

O segundo bloco é responsável por copiar o binário gerado no bloco anterior e executá-lo. A imagem é baseada em `scratch`, que é uma imagem vazia, e vai conter apenas o binário gerado.
```dockerfile
FROM scratch
COPY --from=build /app /app
CMD ["/app"]
```