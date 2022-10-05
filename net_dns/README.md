# DNS 

```
настраиваем split-dns
взять стенд https://github.com/erlong15/vagrant-bind
добавить еще один сервер client2
завести в зоне dns.lab
имена
web1 - смотрит на клиент1
web2 смотрит на клиент2

завести еще одну зону newdns.lab
завести в ней запись
www - смотрит на обоих клиентов

настроить split-dns
клиент1 - видит обе зоны, но в зоне dns.lab только web1

клиент2 видит только dns.lab

*) настроить все без выключения selinux   
```

## Как проверить работоспособность:
 - После отработки vagrant up можно повыполнять dns запросы на client и client2.

Для client:
```
[vagrant@client ~]$ nslookup dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	dns.lab
Address: 192.168.50.11
Name:	dns.lab
Address: 192.168.50.10

[vagrant@client ~]$ nslookup web1.dns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	web1.dns.lab
Address: 192.168.50.15

[vagrant@client ~]$ nslookup web1.dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	web1.dns.lab
Address: 192.168.50.15

[vagrant@client ~]$ nslookup web2.dns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

** server can't find web2.dns.lab: NXDOMAIN

[vagrant@client ~]$ nslookup web2.dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

** server can't find web2.dns.lab: NXDOMAIN
 
[vagrant@client ~]$ nslookup newdns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	newdns.lab
Address: 192.168.50.11
Name:	newdns.lab
Address: 192.168.50.10

[vagrant@client ~]$ nslookup newdns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	newdns.lab
Address: 192.168.50.10
Name:	newdns.lab
Address: 192.168.50.11

[vagrant@client ~]$ nslookup www.newdns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	www.newdns.lab
Address: 192.168.50.16
Name:	www.newdns.lab
Address: 192.168.50.15

[vagrant@client ~]$ nslookup www.newdns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	www.newdns.lab
Address: 192.168.50.16
Name:	www.newdns.lab
Address: 192.168.50.15

```
Для client2:
```
[root@client2 ~]# nslookup dns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	dns.lab
Address: 192.168.50.10
Name:	dns.lab
Address: 192.168.50.11

[root@client2 ~]# nslookup dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	dns.lab
Address: 192.168.50.10
Name:	dns.lab
Address: 192.168.50.11

[root@client2 ~]# nslookup web1.dns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	web1.dns.lab
Address: 192.168.50.15

[root@client2 ~]# nslookup web1.dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	web1.dns.lab
Address: 192.168.50.15

[root@client2 ~]# nslookup web2.dns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

Name:	web2.dns.lab
Address: 192.168.50.16

[root@client2 ~]# nslookup web2.dns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

Name:	web2.dns.lab
Address: 192.168.50.16

[root@client2 ~]# nslookup newdns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

** server can't find newdns.lab: NXDOMAIN

[root@client2 ~]# nslookup newdns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

** server can't find newdns.lab: NXDOMAIN

[root@client2 ~]# nslookup www.newdns.lab 192.168.50.10
Server:		192.168.50.10
Address:	192.168.50.10#53

** server can't find www.newdns.lab: NXDOMAIN
 
[root@client2 ~]# nslookup www.newdns.lab 192.168.50.11
Server:		192.168.50.11
Address:	192.168.50.11#53

** server can't find www.newdns.lab: NXDOMAIN

```

