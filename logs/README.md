В работе использовал journald, systemd-journal-remote, systemd-journal-upload Для передачи в journald логов nginx, добавил в конфиг nginx вывод ошибок и access в

error_log  stderr;
access_log syslog:server=unix:/dev/log;

auditd по умолчанию не выводит в journald сделал systemd юнит который выгружает логи в journald
ExecStart=/bin/sh -c 'tail -f /var/log/audit/audit.log  | systemd-cat -t nginx_conf_audit'

так же юнит для сохрания лога в файл, который отправляется на центральный сервер

Посмотреть и проверить можно следующим образом.

vagrant ssh log
sudo journalctl -D /var/log/journal/remote -f

Сможем мониторить журанл в реальном времени. На хост проброщен порт с web 8080 , в браузере можно вбить localhost:8080 и увидеть дефолтную веб страницу, в логах отобразиться access. Аудит и ошибки nginx можно проверить так. Изменить на web конфиг nginx. вбить в адрес в браузере не существующую страницу, например

localhost:8080/123


