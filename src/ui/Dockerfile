FROM ubuntu:16.04

WORKDIR /app
ADD . /app

RUN apt-get update \
    && apt-get install -y ruby ruby-dev build-essential \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install && apt-get -y purge build-essential ruby-dev \
    && apt-get -y autoremove --purge \
    && rm -rf /var/lib/apt

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
CMD ["puma"]
