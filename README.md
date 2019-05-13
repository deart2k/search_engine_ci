# search_engine_ci

## Описание проекта:

 - В качестве CI настроен Jenins (https://jenkins.deart2k.com/view/Search%20Engine/) в котором созданы проекты Multibranch Pipeline для search_engine_crawler и search_engine_ui. Особенностью Multibranch Pipeline является то, что для каждого бранча автоматически создается отдельная job-а, а правила сборки описываются в файле с названием Jenkinsfile, который находится в корне каждого репозитория search_engine_crawler и search_engine_ui соответственно. Результатом сборки каждого из проектов является образ docker, который после успешного тестирования публикуется на Docker hub. При этом метка образа совпадает с названием бранча.
 - Для установки собранных артефактов из ветки develop в google cloud пока вручную была создана виртуальная машина, на которую с помощью ansible был установлен docker.
 - создан репозиторий search_engine_ci в котором в папке ansible находится playbook для установки docker и другого необходимого ПО на виртуальную машину, а в паке deploy добавлены два файла docker-compose-mr.yml и docker-compose.yml. Первый поднимает MongoDB и RabbitMQ, а второй запускает наши приложения из образов с меткой develop.
 - создан job-а Deploy Search Engine, которая останавливает контейнеры с приложениями, делает pull из docker hub и запускает контейнеры снова.
 - в Jenkinsfile при сборке ветки develop, после публикации образов, добавлен шаг запускающий Deploy Search Engine.

 Т.е. при каждом пуше в репозиторий создается образ с именем ветки в метке, а в если эта ветка develop, то обновляется так же приложение на виртуальной машине.

## Логирование

Логирование реализовано с использованием fluentd, elasticsearch и kibana
Образ fluentd создается из Dockerfile в папке logging/fluentd и должен быть опубликован на Doker hub

## Мониторинг и алертинг

Мониторин реализован с использованием prometheus, node-exporter и grafana
Образ prometheus создается из Dockerfile в папке monitoring/prometheus и должен быть опубликован на Doker hub

Алертинг реализован с использованием alertmanager
Образ alertmanager создается из Dockerfile в папке monitoring/alertmanager и должен быть опубликован на Doker hub

## Запуск

Для запуска проекта выполните start.sh из директории deploy