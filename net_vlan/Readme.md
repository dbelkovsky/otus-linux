# OTUS ДЗ Сетевые пакеты. VLAN'ы. LACP (Centos 7) 

```
Строим бонды и вланы
в Office1 в тестовой подсети появляется сервера с доп интерфесами и адресами
в internal сети testLAN
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1
- testServer2- 10.10.10.1

равести вланами
testClient1 <-> testServer1
testClient2 <-> testServer2

между centralRouter и inetRouter
"пробросить" 2 линка (общая inernal сеть) и объединить их в бонд
проверить работу c отключением интерфейсов

для сдачи - вагрант файл с требуемой конфигурацией
Разворачиваться конфигурация должна через ансибл
```

- Используется vagrant и ansible


## Схема:

![Image 1](https://raw.githubusercontent.com/staybox/otus_dz21/master/screenshots/schema.png)


## Реализовано:

- vlan с одинаковой адресацией в двух разных виртуальных сегментах (сети изолированы с помощью vlan)

![Image 2](https://raw.githubusercontent.com/staybox/otus_dz21/master/screenshots/showvlan-ifcfg.png)

![Image 3](https://raw.githubusercontent.com/staybox/otus_dz21/master/screenshots/showvlan.png)

- bond из двух интерфейсов на машине ```centralRouter``` и ```inetRouter```, параметры, которые использованы в конфигурационном файле интерфейса bond0:

    - ```mode=1``` - определяет политику поведения объединенных интерфейсов. 1 - это политика активный-резервный.

    - ```miimon=100``` - Устанавливает периодичность MII мониторинга в миллисекундах. Фактически монитринг будет осуществляться 10 раз в секунду (1с = 1000 мс).

    - ```fail_over_mac=1``` - Определяет как будут прописываться MAC адреса на объединенных интерфейсах в режиме active-backup при переключении интерфесов.

    Источник информации - http://www.adminia.ru/linux-bonding-obiedinenie-setevyih-interfeysov-v-linux/

![Image 4](https://raw.githubusercontent.com/staybox/otus_dz21/master/screenshots/bond.png)

![Image 5](https://raw.githubusercontent.com/staybox/otus_dz21/master/screenshots/bond_ifcfg.png)

Интерфейсы имеют разные MAC адреса. Bond интерфейс использует MAC адрес того интерфейса, который в данный момент Active.

- Интернет работает с тестовых машин


## Как проверить работоспособность:

- Зайти на ```centralRouter``` или на ```inetRouter``` и ```cat /proc/net/bonding/bond0```

- Зайти на тестовые машины ```testClient1```, ```testClient2```, ```testServer1``` и ```testServer2``` и посмотреть что настроен Vlan и работает интернет
