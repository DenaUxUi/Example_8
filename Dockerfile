# Этап 1: билдим бинарник
FROM golang:1.21 as builder

WORKDIR /app

COPY . .

RUN go mod init myapp && go mod tidy

RUN go build -o server

# Этап 2: минимальный контейнер
FROM debian:bookworm-slim

# Переменные окружения (если хочешь задать порт)
ENV PORT=8080

# Копируем бинарник из билдера
COPY --from=builder /app/server /server

# Указываем порт (документально, не обязательно)
EXPOSE 8080

# Запуск сервера
ENTRYPOINT ["/server"]
