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
