FROM ruby:alpine

WORKDIR /app
ADD . /app

RUN apk --no-cache --update add ruby-full ruby-dev build-base \
    && gem install bundler \
    && bundle update --bundler \
    && bundle install \
    && apk del build-base ruby-dev

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292
CMD ["puma"]
