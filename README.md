# eugenebbr_microservices
eugenebbr microservices repository

***Домашнее задание N14***
***Технология контейнеризации. Введение в Docker***

В ходе выполнения домашнего задания был установлен Docker, запущен тестовый контейнер hello-world.
Были протестированы различные команды, также был создан образ и контейнера и выполнены команды inspect на образе и на контейнере. Результаты сравнения записаны в файл docker-monolith/docker-1.log.
Был создан новый проект в GCP и поднят докер-хост.
Создан Dockerfile нашего приложения, затем из него создан образ и запущен контейнер в GCP.
После тестирования образ был загружен в Docker Hub.

В ходе выполнения домашнего задания со (*) было реализовано:

1. Поднятие инстансов через terraform
2. Установка на них докера и образ нашего приложения через плейбуки Ansible
3. Шаблон пакера, создающий образ с установленным докером


***Домашнее задание N15***
***Docker-образы. Микросервисы.***

В ходе выполнения домашнего задания мы разделили наше приложение на три компоненты: сервис отвечающий за комментарии, сервис отвечающий за посты и веб-интерфейс приложения.
Для каждого из сервисов собрали докер-образ, создали сеть для взаимодействия контейнеров и сетевыве алиасы контейнерам.
В задаче со (*) задали новые алиасы через переменные окружения, чтобы не пересоздавать образ.
Мы улучшили наши образы, выбрав в качестве основного образа Alpine Linux, а также уменьшив количество слоев.
После этого проверили сохранение данных в БД, создав volume и подключив его к нужному контейнеру.

***Домашнее задание N16***
***Docker: сети, docker-compose***

В ходе домашнего задания мы запустили контейнер с использованием none-драйвера, в сетевом пространстве docker-хоста.
Запустили несколько раз команду:

```
docker run --network host -d nginx
```

Запустился только один докер-контейнер, так как нельзя в сетевом пространстве хоста иметь несколько контейнеров, слушающих один и тот же порт.

Посмотрели как меняется список namespace'ов с использованием драйверов none и host - host-драйвер не создает новый namespace, в отличие от none-драйвера.

Создали bridge-сеть и проверили работу сетевых алиасов, создали отдельные сети для докер-контейнеров, посмотрели какие правила создает iptables на докер хосте для работы наших контейнеров

Установили docker-compose, описали запуск наших контейнеров в нем, создание подсетей, параметризовали часть ресурсов для контейнеров и записали переменные в файл .env.

По-умолчанию docker-compose создает префикс ко всем сущностям, исходя из названия папки, откуда запускается. Это можно изменить несколькими способами:

```
docker-compose -p PROJECT_NAME
```

Добавить переменную окружения COMPOSE_PROJECT_NAME

В ходе выполнения задачи со (*) был создан файл docker-compose.override.yml
В него было добавлено монтирование локальных папок приложений в соответствующие контейнеры и запуск приложения с параметрами дебага и двумя воркерами.
Работает docker-compose.override.yml в локальной среде. С использование mount на удаленном docker-host поднимался только контейнер с БД.

***Домашнее задание N17***
***Устройство Gitlab CI. Построение процесса непрерывной поставки***

В ходе выполнения домашнего задания была создана ВМ для построения процесса CI (с помощью terraform), был установлен Docker (с помощью Ansible), поднят контейнер с Gitlab CI.
В Gitlab CI был создан учебный проект и тестовый pipeline.
После этого был создан runner для запуска заданий нашего pipeline.
Был добавлен код приложения reddit, в pipeline были описаны stage для сборки, тестирования и деплоя приложения.
Добавлены два окружения в наш проект, а также настроены динамические окружения.

В шаг build была добавлена сборка контейнера с нашим приложением и отправкой его на dockerhub.
В шаге deploy был добавлен деплой нашего контейнера на созданный для этого сервер и проверена доступность по 9292 порту.
Реализован функционал автоматического добавления Gitlab CI Runner. Для этого был использован Ansible и community-роль "riemers.gitlabrunner".
Настроена интеграция pipeline с тестовым slack-чатом, ссылка на канал для проверки: https://devops-team-otus.slack.com/archives/CUVQNH3K4

(#evgeny_bratchenko)

***Домашнее задание N18***
***Введение в мониторинг. Системы мониторинга***

В ходе выполнения домашнего задания был создан контейнер с системой мониторинга Prometheus, изучено как собираются и отображаются метрики, что такое цели и как за ним следит Prometheus.
Далее был собран докер-образ Prometheus с конфигурацией (файл prometheus.yml) для мониторинга наших сервисов.
Были собраны образы наших микросервисов с healthcheck-ами.
Поднятие образа Prometheus было добавлено в файл docker-compose.yml
После поднятия всех сервисов, проверено как Prometheus отображает состояние сервисов, как отображает на графике и в консоли падение сервиса, поднятие, рост нагрузки.
Был создан экспортер (node-exporter) для транслирования метрик приложений для Prometheus, также добавлен в файл docker-compose.yml

В ходе выполнения задания со (*) был создан файл Makefile, в него было добавлено: разворачивание/удаление docker-machine, билд любого образа/всех образов, пуш в DockerHub любого образа/всех образов.
Был добавлен мониторинг MongoDB с использованием экспортера percona/mongodb_exporter.
Был добавлен мониторинг сервисов ui, comment и post с использованием экспортера prom/blackbox-exporter.
Все образы запушены на Dockerhub.

https://hub.docker.com/u/eugenebbrdocker

***Домашнее задание N19***
***Мониторинг приложения и инфраструктуры***

В ходе выполнения домашнего задания был разделен файл docker-compose.yml на два, отделено описание приложений от мониторинга.
Был поднят cAdvisor в контейнере, собирающий информацию о наших контейнерах и их работе, Grafana - инструмент визуализации данных из Prometheus.
В Grafana в качестве источника данных был добавлен Prometheus. Был скачан и импортирован в Grafana дашборд для визуализации состояния хостовой системы и контейнеров.
Создан дашборд для мониторинга приолжения, который отслеживает правильные запрос (200 ОК) и ошибочные (404, 501), дашборд для проверки времени обработки запроса страницы приложения и дашборд вычисления 95-ого процентиля.
Для мониторинга бизнес-логики были созданы дашборды показывающие количество постов и комментов в час.
Добавлен компонент мониторинга - Alertmanager для обработки и отправки оповещений. Интегрирован с тестовым Slack, проверена работа вебхуков.

***Домашнее задание N20***
***Логирование и распределенная трассировка***

В ходе выполнения домашнего задания был обновлен код микросервисов нашего приложения.
В качестве системы централизованного логирования выбран EFK стек (ElasticSearch, Fluentd, Kibana) и описан в файле docker-compose-logging.yml
Был сконфигурирован и собран образ fluentd, а для сервиса post изменен драйвер логирования с json на fluentd.
В Kibana был просмотрен внешний вид логов и для удобства просмотра добавлен фильтр в конфиг fluentd для парсинга json логов.
Аналогично добавлен драйвер логирования для сервиса ui, так как сервис пишет неструктурированные логи используются регулярные выражения, а для удобства задач парсинга - grok-шаблоны.
Для одного из форматов лога сервиса UI написан свой grok-шаблон

```
<grok>
    pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{URIPATH:path} \| request_id=%{GREEDYDATA:request_id} \| remote_addr=%{IP:remote_addr} \| method=%{WORD:method} \| response_status=%{NUMBER:response_status}
</grok>
```

Для распределенного трейсинга в docker-compose-logging.yml был добавлен сервис Zipkin, а для сервисов приолжения включен параметр ZIPKIN_ENABLED в режим true.
Несколько раз обновлена главная страница нашего приложения, определено время обработки нашего запроса к ui-сервису.
Было скопировано сломанное приложение, развернуто, найдены и исправлены следующие ошибки:

1. В dockerfile сервиса post не описаны переменные POST_DATABASE_HOST и POST_DATABASE, решено внесением их в docker-compose.yml (В zipkin ошибка 500)
2. В dockerfile сервиса comment не описаны переменные COMMENT_DATABASE_HOST и COMMENT_DATABASE, решено внесением их в docker-compose.yml (В zipkin ошибка 500)
3. В bugged-code\post-py\post_app.py добавлена строчка time.sleep(3) (в zipkin задержка в 3с при обращении)

***Домашнее задание N21***
***Введение в Kubernetes***

В ходе домашнего задания был поднят k8s, используя The Hard Way (https://github.com/kelseyhightower/kubernetes-the-hard-way).
Все полученные файлы находятся в kubernetes\the_hard_way.
В README решено не копировать многостраничное руководство.

***Домашнее задание N22***
***Kubernetes. Запуск кластера и приложения. Модель безопасности***

В ходе выполнения домашнего задания был установлен Minikube, созданы YAML-манифесты.
Развернуто приложение и проверена доступность извне.
Запущен дашборд, проверен его функционал.
Аналогично поднят кластер Kubernetes в GCP, развернуто приложение в нем и включен дашборд.
Скриншот доступен по ссылке https://ibb.co/VNFxM85

В ходе выполнения задания со (*) было создано две версия деплоя кластера Kubernetes в GCP: по ссылке в ДЗ и с помощью модулей gruntwork.io

***Домашнее задание N23***
***Kubernetes. Networks. Storages***

В ходе выполнения домашнего задания были подробнее разобраны способы коммуникации Endpoints в Kubernetes, а именно nodePort, LoadBalancer, ClusterIP.
Проверена связность компонентов приложения при отключенном kube-dns - перестает работать.
Был создан и настроен Ingress для нашего сервиса UI. Для выполнения задания со (*) был создан объект Secret, использующий сгенерированный самоподписанный сертификат для защиты нашего сериса с помощью TLS.
Протестирован сетевой плагин Calico в качестве инструмента для декларативного описания потоков трафика.
Вместо локального хранилища данных для mongodb был создан удаленный volume gcePersistentDisk в GCE и примонтирован к POD'у с mongodb.
Был создан ресурс ресурс, распространенный на весь кластер, в виде PersistentVolume, а также запрос на выдачу Claim.
Описаны StorageClass динамическое подключение volume к PVC.
