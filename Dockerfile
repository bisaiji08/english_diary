FROM ruby:3.2.2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn
WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install
