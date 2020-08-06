FROM ruby:2.7.1

RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install -j4

COPY . /app
