#!/bin/bash

docker-compose -f docker-compose-mr.yml up -d # запуск mongodb и rabbitmq
docker-compose -f docker-compose-logging.yml up -d # запуск fluentd, elasticsearch, kibana 
docker-compose -f docker-compose-monitoring.yml up -d # запуск node-exporter, prometheus, cadvisor, grafana и alertmanager
docker-compose up -d # запуск приложения	