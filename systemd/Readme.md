Для выполнения задания понадобилось использовать нижеперечисленные команды . Конфиги брал из методички.
1. Написать сервис.
 
cd /etc/sysconfig/
touch watchlog
vi watchlog 
touch /var/log/watchlog.log
vi  /var/log/watchlog.log
ll
tail /var/log/messages >> /var/log/watchlog.log 
tail /var/log/watchlog.log 
vi  /var/log/watchlog.log
vi /opt/watchlog.sh
chmod +x /opt/watchlog.sh
vi /etc/systemd/system/watchlog.service
vi /etc/systemd/system/watchlog.timer
systemctl enable watchlog.timer
systemctl start watchlog.timer
tail /var/log/watchlog.log 
systemctl start watchlog.timer 
tail /var/log/watchlog.log 
tail /var/log/messages 

Jun  7 20:09:07 localhost systemd: Started My watchlog service.
Jun  7 20:09:34 localhost systemd: Created slice User Slice of vagrant.
Jun  7 20:09:34 localhost systemd: Started Session 25 of user vagrant.
Jun  7 20:09:34 localhost systemd-logind: New session 25 of user vagrant.
Jun  7 20:09:37 localhost systemd: Starting My watchlog service...
Jun  7 20:09:37 localhost root: Tue Jun  7 20:09:37 UTC 2022: I found word, Master!
Jun  7 20:09:37 localhost systemd: Started My watchlog service.
Jun  7 20:10:07 localhost systemd: Starting My watchlog service...
Jun  7 20:10:07 localhost root: Tue Jun  7 20:10:07 UTC 2022: I found word, Master!
Jun  7 20:10:07 localhost systemd: Started My watchlog service.
 
2. Из репозитория epel установить spawn-fcgi и переписать init-скрипт 


yum install epel-release -y && yum install spawn-fcgi php php-cli
vi etc/rc.d/init.d/spawn-fcg
vi /etc/rc.d/init.d/spawn-fcg
vi /etc/sysconfig/spawn-fcgi
vi /etc/systemd/system/spawn-fcgi.service
systemctl start spawn-fcgi.service 
systemctl status spawn-fcgi.service 
[root@sysD ~]# systemctl status spawn-fcgi.service 
● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2022-06-07 03:34:04 UTC; 16h ago
 Main PID: 23146 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─23146 /usr/bin/php-cgi
           ├─23147 /usr/bin/php-cgi
           ├─23148 /usr/bin/php-cgi
           ├─23149 /usr/bin/php-cgi
           ├─23150 /usr/bin/php-cgi
           ├─23151 /usr/bin/php-cgi
           ├─23152 /usr/bin/php-cgi
           ├─23153 /usr/bin/php-cgi
           ├─23154 /usr/bin/php-cgi
           ├─23155 /usr/bin/php-cgi
           ├─23156 /usr/bin/php-cgi
           ├─23157 /usr/bin/php-cgi
           ├─23158 /usr/bin/php-cgi
           ├─23159 /usr/bin/php-cgi
           ├─23160 /usr/bin/php-cgi
           ├─23161 /usr/bin/php-cgi
           ├─23162 /usr/bin/php-cgi
           ├─23163 /usr/bin/php-cgi
           ├─23164 /usr/bin/php-cgi
           ├─23165 /usr/bin/php-cgi
           ├─23166 /usr/bin/php-cgi
           ├─23167 /usr/bin/php-cgi
           ├─23168 /usr/bin/php-cgi
           ├─23169 /usr/bin/php-cgi
           ├─23170 /usr/bin/php-cgi
           ├─23171 /usr/bin/php-cgi
           ├─23172 /usr/bin/php-cgi
           ├─23173 /usr/bin/php-cgi
           ├─23174 /usr/bin/php-cgi
           ├─23175 /usr/bin/php-cgi
           ├─23176 /usr/bin/php-cgi
           ├─23177 /usr/bin/php-cgi
           └─23178 /usr/bin/php-cgi

3. Дополнить unit-файл httpd (он же apache) возможностью запустить несколько инстансов 

yum  install lsof
cp /usr/lib/systemd/system/httpd.service /etc/systemd/system
mv /etc/systemd/system/httpd.service /etc/systemd/system/httpd@.service
vi /etc/systemd/system/httpd@.service
vi /etc/sysconfig/httpd-first
vi /etc/sysconfig/httpd-second
ll  /etc/httpd/conf/
cat  /etc/httpd/conf/httpd.conf 
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf 
cp /etc/httpd/conf/first.conf /etc/httpd/conf/second.conf 
ll /etc/httpd/conf/
vi /etc/httpd/conf/second.conf 
cat  /etc/httpd/conf/second.conf |  grep -i  -A5 -B5  pid
echo 'PidFile /var/run/httpd-second.pid' >> /etc/httpd/conf/second.conf 
cat  /etc/httpd/conf/second.conf |  grep -i  -A5 -B5  pid
systemctl start httpd@first
systemctl start httpd@second
lsof -i -P | grep :80   
httpd    25360    root    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25361  apache    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25362  apache    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25363  apache    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25364  apache    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25365  apache    4u  IPv6  80309      0t0  TCP *:8080 (LISTEN)
httpd    25560    root    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)
httpd    25561  apache    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)
httpd    25562  apache    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)
httpd    25563  apache    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)
httpd    25564  apache    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)
httpd    25565  apache    4u  IPv6  84033      0t0  TCP *:80 (LISTEN)

Все менроприятия можно повторить на стенде, все работает.





