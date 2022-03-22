FROM ruby:3.0.3
RUN apt-get update -qq &&\
    apt-get install -y build-essential libpq-dev nodejs imagemagick apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt-get update && apt-get install yarn

RUN export PATH="$PATH:/opt/yarn-[version]/bin"

RUN gem install bundler

RUN mkdir /schorpong
WORKDIR /schorpong

ARG APP_SECRET
ARG APP_ID
ARG SECRET_KEY_BASE

# Install dependencies
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --deployment --without test development --retry 3

# Copy application
COPY . .

# Build assets
RUN RAILS_ENV=production bundle exec rake assets:precompile
