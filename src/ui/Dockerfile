FROM ubuntu:16.04

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

# Помещаем команды в один слой и удаляем неиспользуемые пакеты
RUN apt-get update \
    && apt-get install -y ruby ruby-dev build-essential \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install && apt-get -y purge build-essential ruby-dev \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt

ADD . $APP_HOME
ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
CMD ["puma"]
