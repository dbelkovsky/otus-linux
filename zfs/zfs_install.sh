#!/bin/bash
#Права суперпользователя
sudo -i
#Добавляем репозитории
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#Ставим пакеты для yum
yum install -y yum-utils
# Скачиваем пакеты 
yum install -y https://zfsonlinux.org/epel/zfs-release.el8_5.noarch.rpm
#Импортируем ключ
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
#Ставим утилиты для корректной работы 
yum install -y epel-release kernel-devel zfs
#Меняем репозиторий
yum-config-manager --disable zfs
yum-config-manager --enable zfs-kmod
#Ставим zfs
yum install -y zfs
#Добавляем модуль в ядро
modprobe zfs
#Ставим утилиту wget
yum install -y wget
