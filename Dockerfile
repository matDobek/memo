FROM ruby:2.6.0-alpine3.8

WORKDIR /app

RUN apk --no-cache add \
  bash \
  less

COPY . /app

RUN ./bin/install.sh
