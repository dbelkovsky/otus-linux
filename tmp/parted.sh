#!/bin/bash

#изменение дискового пространства с помощью утилиты parted

#Для начала воспользуемся правами суперпользователя
sudo -i
#создадим gpt раздел на базе нашего RAID
parted -s /dev/md0 mklabel gpt
#создадим 5 партиций
parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%
#создадим на партициях файловую систему, в нашем случае это ext4
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
#Создадим каталоги для монтирования наших фс
mkdir -p /raid/part{1,2,3,4,5}
#Примонтируем фс к точакам монтирования.
for i in $(seq 1 5); do sudo mount /dev/md0p$i /raid/part$i; done		
#Проверим вывод
df -h
