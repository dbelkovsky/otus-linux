#!/bin/bash
#Привелегии
sudo -i
# Установка утилит для работы с nfs
yum install nfs-utils -y
# Задействуем файрвол
systemctl enable firewalld --now
# Добавляем запись для монтирования
echo "192.168.50.10:/srv/share/upload /mnt/share/upload nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0
">> /etc/fstab
# Перезапускаем 
systemctl daemon-reload
# Перезапускаем
systemctl restart remote-fs.target


