Способ 1.

1. Запускаем ВМ.
2. При старте в меню GRUB2 нажимаем на клашиву "e".
3. В строке Linux16 убираем  все значения console: console=tty0 console=ttyS0,115200n8.
4. Добавляем запись "rd.break", и жмем Ctrl+X.
5. Система загружается в аварийном режиме.
6. Выполняем команду перемонтирования корня для чтения и записи - mount -o remount,rw /sysroot, далее chroot /sysroot
7. Меняем пароль: passwd (можно passwd root)
8. Если в системе включен selinux, то необходимо создать скрытый файл в корне .autorelabel (touch /.autorelabel), поможет перечитать файлы в системе при перезагрузке и тогда пустит нас в систему.
9. Перезагружаемся exit 
10. Выполяем вход root "pass"
 
Способ 2.

1. Запускаем ВМ.
2. При старте в меню GRUB2 нажимаем на клашиву "e".
3. В строке Linux16 убираем значения console: console=tty0 console=ttyS0,115200n8.
4. Добавляем значение init=/bin/sh и жмем Ctrl+X.
5. Система загружается.
6. Выполняем команду перемонтирования корня для чтения и записи - mount -o remount,rw / .
7. Меняем пароль: passwd
8. Проверяем SELUX:  cat /etc/selinux/config, если SELINUX=Enforcing, то меняем или на Permissive или Disabled.
9. Перезагружаемся exit.
10. Заходим в систему по новому паролю.

Создание VM с LVM и переименование VG.


bdn@PC:~/git/otus-linux/grub2$ vagrant ssh 

[vagrant@lvm ~]$ sudo -i

[root@lvm ~]# lsblk

NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 

├─sda1                    8:1    0    1M  0 part 

├─sda2                    8:2    0    1G  0 part /boot

└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]

sdb                       8:16   0    1G  0 disk 

sdc                       8:32   0    1G  0 disk 

sdd                       8:48   0    1G  0 disk 

sde                       8:64   0    1G  0 disk 
[root@lvm ~]# pvs
 
 PV         VG         Fmt  Attr PSize   PFree
  /dev/sda3  VolGroup00 lvm2 a--  <38.97g    0 


[root@lvm ~]# lvs
 
 LV       VG         Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
 
 LogVol00 VolGroup00 -wi-ao---- <37.47g                                                    
 
 LogVol01 VolGroup00 -wi-ao----   1.50g                                                    

[root@lvm ~]# vgrename VolGroup00 otustest
 
 Volume group "VolGroup00" successfully renamed to "otustest"


[root@lvm ~]# lvs
 
 LV       VG       Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
 
 LogVol00 otustest -wi-ao---- <37.47g                                                    
 
 LogVol01 otustest -wi-ao----   1.50g                                                    


[root@lvm ~]# lsblk

NAME                  MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT

sda                     8:0    0   40G  0 disk 

├─sda1                  8:1    0    1M  0 part 

├─sda2                  8:2    0    1G  0 part /boot

└─sda3                  8:3    0   39G  0 part 
  ├─otustest-LogVol00 253:0    0 37.5G  0 lvm  /
  └─otustest-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]

sdb                     8:16   0    1G  0 disk 

sdc                     8:32   0    1G  0 disk 

sdd                     8:48   0    1G  0 disk 

sde                     8:64   0    1G  0 disk 

