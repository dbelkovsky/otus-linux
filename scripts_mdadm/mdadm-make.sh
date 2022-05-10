#!/bin/bash
#Создаем raid6

#Переходим в режим суперпользователя
sudo -i
#Заполняем нулями необходимое досковое простанстрво
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
#Сознаем Raid 6 из 5 дисков
mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}

#Создание raid после перезагрузки системы

#Создаем директорию для хранения конфига
mkdir /etc/mdadm
#Записываем в файл парамеры
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
#Передаем в файл вывод команды mdadm 
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf



