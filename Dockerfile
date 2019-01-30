FROM ruby:2.6.0-alpine3.8

WORKDIR /app

RUN apk --no-cache add \
  make \
  less

COPY Makefile Gemfile Gemfile.lock .ruby-version ./

RUN make install

COPY . /app
