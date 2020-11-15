#FROM ubuntu:16.04

# Используем образ alpine
FROM alpine
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
# Помещаем команды в один слой и удаляем неиспользуемые пакеты
#RUN apt-get update \
#    && apt-get install -y ruby ruby-dev build-essential \
#    && gem install bundler --no-ri --no-rdoc \
#    && bundle install && apt-get -y purge build-essential ruby-dev \
#    && apt-get -y autoremove --purge \
#    && rm -rf /var/lib/apt

# Помещаем команды в один слой и удаляем неиспользуемые пакеты
RUN apk update && apk add ruby-bundler ruby-dev build-base \
    && bundle update --bundler && bundle install \
    && apk del build-base ruby-dev

COPY . $APP_HOME
ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
CMD ["puma"]
