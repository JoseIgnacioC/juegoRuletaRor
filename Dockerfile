FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /juegoRuletaRor
WORKDIR /juegoRuletaRor

ADD Gemfile /juegoRuletaRor/Gemfile
ADD Gemfile.lock /juegoRuletaRor/Gemfile.lock

#Install cron and start
RUN apt-get update && apt-get -y install cron

RUN bundle install

ADD . /juegoRuletaRor