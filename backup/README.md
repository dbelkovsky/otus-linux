Настраиваем бэкапы

В вагранте создается отдельнвый vdi который монтируется для бэкапа.
SSH ключи автоматически отправляются на сервер через nfs шару.
для автоматизации использовал юнит и  таймер sustemd.
вывод в journald через logger.

получим список бэкапов
```
[vagrant@client ~]$ sudo borg list borg@backupserver:/var/backup/repo/client
Remote: Warning: Permanently added 'backupserver,192.168.10.10' (ECDSA) to the list of known hosts.
Enter passphrase for key ssh://borg@backupserver/var/backup/repo/client: 
```
удаляю директорию
```
rm -rf /etc/yum
```
извлечем удаленыый контент из поледнего бэкапап, посмотрим его содержимое
```
sudo borg list borg@backupserver:/var/backup/repo/client::client-
```
извлекаем
```
sudo borg extract borg@backupserver:/var/backup/repo/client::
```
результат
```
[vagrant@client ~]$ sudo ls etc
yum
```
