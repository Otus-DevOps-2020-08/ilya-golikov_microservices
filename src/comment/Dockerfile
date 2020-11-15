FROM alpine:latest

WORKDIR /app
ADD . /app

RUN ["busybox", "sh", "-c", "apk --no-cache --update add ruby-bundler ruby-dev build-base \
    && bundle update --bundler \
    && bundle install \
    && apk del build-base ruby-dev"]

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments
CMD ["puma"]
