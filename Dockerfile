FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /letsmeet
WORKDIR /letsmeet
COPY Gemfile /letsmeet/Gemfile
COPY Gemfile.lock /letsmeet/Gemfile.lock
RUN bundle install
CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
