[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices)

# ilya-golikov_microservices
ilya-golikov microservices repository

## Задание к лекции №16

- создана ветка docker-2 в репозитории _microservices;

- Установлен docker, docker-compose, docker-machine

- В Yandex.cloud создан docker-host;

- Создан и залит в docker hub образ с приложением reddit;

- Настроен прототип инфраструктуры в директории docker-monolith/infra;

- Инстансы поднимаются терраформом, количество задается переменной;

- Плейбуками ansible разворачивается докер на инстансах и деплоится приложение.

- Написан шаблон пакера, подготавливающий образ с уже установленным docker;
