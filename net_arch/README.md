Выполнение задания:


Теоретическая часть (задание)
- Найти свободные подсети
- Посчитать сколько узлов в каждой подсети, включая свободные
- Указать broadcast адрес для каждой подсети
- проверить нет ли ошибок при разбиении


**Сеть office1**


- 192.168.2.0/26 - dev 
Network:   192.168.2.0/26
Broadcast: 192.168.2.63
HostMin:   192.168.2.1
HostMax:   192.168.2.62
Hosts: 62
- 192.168.2.64/26 - test servers 
Network:   192.168.2.64/26
Broadcast: 192.168.2.127
HostMin:   192.168.2.65
HostMax:   192.168.2.126
Hosts: 62
- 192.168.2.128/26 - managers
Network:   192.168.2.128/26
Broadcast: 192.168.2.191
HostMin:   192.168.2.129
HostMax:   192.168.2.190
Hosts: 62
- 192.168.2.192/26 - office hardware
Network:   192.168.2.192/26
Broadcast: 192.168.2.255
HostMin:   192.168.2.193
HostMax:   192.168.2.254
Hosts: 62

**Сеть office2**

- 192.168.1.0/25 - dev 
Network:   192.168.1.0/25
Broadcast: 192.168.1.127
HostMin:   192.168.1.1
HostMax:   192.168.1.126
Hosts: 126
- 192.168.1.128/26 - test servers
Network:   192.168.1.128/26
Broadcast: 192.168.1.191
HostMin:   192.168.1.129
HostMax:   192.168.1.190
Hosts: 62
- 192.168.1.192/26 - office hardware 
Network:   192.168.1.192/26
Broadcast: 192.168.1.255
HostMin:   192.168.1.193
HostMax:   192.168.1.254
Hosts: 62

**Сеть central**

- 192.168.0.0/28 - directors 
Network:   192.168.0.0/28
Broadcast: 192.168.0.15
HostMin:   192.168.0.1
HostMax:   192.168.0.14
Hosts: 14       

- 192.168.0.32/28 - office hardware
Network:   192.168.0.32/28
Broadcast: 192.168.0.47
HostMin:   192.168.0.33
HostMax:   192.168.0.46
Hosts: 14 

- 192.168.0.64/26 - wifi
Network:   192.168.0.64/26
Broadcast: 192.168.0.127
HostMin:   192.168.0.65
HostMax:   192.168.0.126
Hosts: 62

**Свободные подсети**

- 192.168.0.16/28 - Свободна
- Broadcast: 192.168.0.31

- 192.168.0.48/28 - Свободна
- Broadcast: 192.168.0.63

- 192.168.0.128/25 - Свободна
- Broadcast: 192.168.0.255
