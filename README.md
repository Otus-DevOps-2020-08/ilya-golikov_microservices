[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ilya-golikov_microservices)

# ilya-golikov_microservices
ilya-golikov microservices repository

## Задание к лекции №27

- создана ветка kubernetes-1;

- созданы файлы с Deployment манифестами приложений;

- пройден курс Kubernetes: The Hard way;

## Задание к лекции №25

- создана ветка logging-1;

- Запущен и настроен docker-host в облаке Yandex Cloud;

- Создан docker-compose-logging.yml;

- Собран docker образ fluentd;

- Настроена Kibana;

- Настроен сбор структурированных логов c помощью фильтров во fluentd;

- Настроен сбор неструктурируемых логов; добавлены grok-шаблоны;

- Задание со⭐: Добавлен grok шаблон для оставшегося неразобранного формата логов:

  Grok-шаблон:
  ```
  service=%{WORD:service} \| event=%{WORD:event} \| path=%{UNIXPATH:path} \| request_id=%{GREEDYDATA:request_id} \| remote_addr=%{IPV4:remote_address} \| method=%{DATA:method} \| response_status=%{BASE10NUM:response_status}
  ```
- Установлена система распределенного трейсинга zipkin;

- Задание со⭐: С помощью системы распределенного трейсинга была выявлена 3 секундная задержка в запросе `GET` к адресу `/post/<id>`. Виновником задержки был вызов `time.sleep(3)` в функции `find_post(id)`.

## Задание к лекции №22

- создана ветка monitor-1;

- Запущен и настроен docker-host в облаке Yandex Cloud;

- Запущен контейнер с prometheus;

- Создана конфигурация и докерфайл prometheus; Собран образ prometheus с необходимыми настройками;

- Собраны образы reddit app;

- В docker-compose.yml добавлен сервис prometheus;

- Настроен мониторинг сервисов;

- Добавлен node_exporter для сбора метрик с докер-хоста;

- \* Добавлен [percona/mongodb_exporter](https://github.com/percona/mongodb_exporter) для сбора метрик с MongoDB; Dockerfile для сборки образа в monitoring/mongodb_exporter;

- \* Добавлен и настроен blackbox_exporter для проверки работы сервисов ui, post и comment;

- \* Создан Makefile, который собирает образы по отдельносьти и вместе, заливает их на docker hub, поднимает и уничтожает инфраструктуру описанную в docker/docker-compose.yml;

- Все собранные образы залиты на docker-hub:
  - [comment](https://hub.docker.com/repository/docker/userkiller/comment)
  - [ui](https://hub.docker.com/repository/docker/userkiller/ui)
  - [prometheus](https://hub.docker.com/repository/docker/userkiller/prometheus)
  - [mongodb_exporter](https://hub.docker.com/repository/docker/userkiller/mongodb_exporter)
  - [post](https://hub.docker.com/repository/docker/userkiller/post)

## Задание к лекции №19

- создана веька gitlab-ci-1;

- Создана машина в Yandex.Cloud при помощи Terraform;

- На созданную машину установлен Docker с помощью ansible playbook;

- Установлен gitlab-ci при помощи docker-compose;

- Созданы группа и проект в gitlab;

- Определен пайплайн и залит в gitlab репозиторий;

- Добавлен runner;

- Добавлен reddit к проекту, в пайплайне описан тесты;

- Добавлены окружения stage, prod, добавлены условия для запуска;

- В пайплайне определено создание динамических окружений;

- Задание со *: Написан плейбук для разворачивания Gitlab;

- Задание со *: Запущен Reddit контейере, задан деплой на динамические окружения. Для запуска был использован образ Docker-in-docker, а раннер был добавлен с опциями `--docker-volumes /var/run/docker.sock:/var/run/docker.sock` и `--docker-privileged`;

- Задание со *: К плейбуку разворачивания gitlab добавлен плейбук установки и подключения раннеров;

- Задание со *: Добавлена нотификаия в слак: https://app.slack.com/client/T6HR0TUP3/C01EW5JHELX

## Задание к лекции №18

- ветка docker-4;

- Протестирована работа контейнеров с различными типами сетевых драйверов docker: none, host, bridge

- Приложение развернуто в двух сетях: front и back

- Установлен Docker-compose

- В docker-compose.yml описана инфраструктура , разворачивающая приложение из трех образов в одной сети.

- Внесены изменения в docker-compose.yml: Приложение разворачивается в сетях front и back, для деплоя используются ранее собранные образы.

- Все возможные параметры вынесены в отдельный .env файл.

- Задано имя проекта через параметр docker-compose -p ИМЯ_ПРОЕКТА. Так же, изменить имя можно, добавив переменную в COMPOSE_PROJECT_NAME в .env.

- Создан docker-compose.override.yml который создает volume для каждого контейнера и запускает сервис puma в debug режиме с 2 воркерами.


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

- для уменьшения размера, в качестве основного образа выбран ruby:alpine. Образы удалось сократить до ~110Mb.

- проведена оптимизация докерфайлов.

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
