FROM ruby:alpine

WORKDIR /app
ADD . /app

RUN apk --no-cache --update add ruby-full ruby-dev build-base && \
    gem install bundler && \
    bundle update --bundler && \
    bundle install && \
    apk del build-base ruby-dev

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
CMD ["puma"]
