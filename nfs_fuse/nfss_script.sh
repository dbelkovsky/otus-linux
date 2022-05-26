#!/bin/bash
#Привелегии
sudo -i
# Установка утилит для работы с nfs
yum install nfs-utils -y
# Задействуем файрвол
systemctl enable firewalld --now
# добавим правила
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
# Перезагрузим для принятия правил
firewall-cmd --reload 
# Задействуем NFS
systemctl enable nfs --now
# Cоздадим директорию 
mkdir -p /srv/share/upload
# Сменим владельца
chown -R nfsnobody:nfsnobody /srv/share/
# Сменим права доступа
chmod 0777 /srv/share/upload/
# Добавим нашу директорию в экспорты
cat << EOF > /etc/exports
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF
# Экспортируем директорию
exportfs -r
# Проверим экспорт
exportfs -s

