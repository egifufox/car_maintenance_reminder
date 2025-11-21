FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    apt-get install -y mariadb-client

WORKDIR /car_maintenance_reminder

RUN gem install bundler:2.3.17

COPY Gemfile /car_maintenance_reminder/Gemfile
COPY Gemfile.lock /car_maintenance_reminder/Gemfile.lock

RUN bundle install

COPY . /car_maintenance_reminder