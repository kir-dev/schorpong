FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /schorpong
WORKDIR /schorpong
COPY Gemfile /schorpong/Gemfile
COPY Gemfile.lock /schorpong/Gemfile.lock
RUN bundle install
COPY . /schorpong
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
