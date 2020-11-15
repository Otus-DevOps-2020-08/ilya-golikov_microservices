[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices)

# ilya-golikov_microservices
ilya-golikov microservices repository

## Задание к лекции №17

- создана ветка docker-3;

- создано 4 образа:
  - post-py - сервис отвечающий за написание постов,
  - comment - сервис отвечающий за написание комментариев,
  - ui - веб-интерфейс, работающий с другими сервисами,
  - образ с базой данных MongoDB

- сервис ui использует тот же образ что и сервис comment, поэтому сборка начинается не с первого шага.

- Осуществлен запуск контейнеров с другими альясами с помощью параметра --env

  ```
  docker run -d --network=reddit --network-alias=mongodb-post --network-alias=mongodb-comment mongo:latest
  docker run -d --network=reddit --env POST_DATABASE_HOST=mongodb-post       --env POST_DATABASE=posts-db           --network-alias=posts user/post:1.0
  docker run -d --network=reddit --env COMMENT_DATABASE_HOST=mongodb-comment --env ENV COMMENT_DATABASE=comments-db --network-alias=comments user/comment:1.0
  docker run -d --network=reddit --env POST_SERVICE_HOST=posts               --env COMMENT_SERVICE_HOST=comments    -p 9292:9292 user/ui:1.0
  ```

- для уменьшения размера образа, пересобран сервис ui с использованием ubuntu:16.04. Сборка начинается с первого шага.

- проведена оптимизация докерфайлов.
  - в сервисе ui команды по установке пакетов перенесены в один слой, так же удалены неиспользуемые пакеты, размер образа 206MB.
  - в comments в качестве основного слоя выбран alpine linux, установлено минимальное окружение для запуска приложения, размер образа 52.6MB.

- для сохранения постов создан и подключен volume к контейнеру БД.

## Задание к лекции №16

- создана ветка docker-2 в репозитории _microservices;

- Установлен docker, docker-compose, docker-machine

- В Yandex.cloud создан docker-host;

- Создан и залит в docker hub образ с приложением reddit;

- Настроен прототип инфраструктуры в директории docker-monolith/infra;

- Инстансы поднимаются терраформом, количество задается переменной;

- Плейбуками ansible разворачивается докер на инстансах и деплоится приложение.

- Написан шаблон пакера, подготавливающий образ с уже установленным docker;
