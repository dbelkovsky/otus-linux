# Otus ДЗ Динамический веб контент. (Centos 8)  

```
Собрать стенд с 3мя проектами на выбор
Варианты стенда
nginx + php-fpm (laravel/wordpress) + python (flask/django) + js(react/angular)
nginx + java (tomcat/jetty/netty) + go + ruby
можно свои комбинации

Реализации на выбор
- на хостовой системе через конфиги в /etc
- деплой через docker-compose

Для усложнения можно попросить проекты у коллег с курсов по разработке

К сдаче примается
vagrant стэнд с проброшенными на локалхост портами
каждый порт на свой сайт
через нжинкс
```

## В процессе сделано:
Настроен Vagrantfile и плейбук ansible для развертки следующей конфигурации:
- проект https://github.com/staybox/django-helloworld c django висит на порту localhost:8000 и проксирутся nginx с порта 83
- проект https://github.com/staybox/go-http-hello-world с go висит на порту localhost:8800 и проксирутся nginx с порта 81
- проект https://github.com/staybox/react-helloworld с react висит на порту localhost:7777 и проксирутся nginx с порта 82


1. GO

![Image 1](https://raw.githubusercontent.com/staybox/otus_dz28/master/screenshots/go.png) 

--------
2. React

![Image 2](https://raw.githubusercontent.com/staybox/otus_dz28/master/screenshots/react.png) 

--------
3. Django

![Image 3](https://raw.githubusercontent.com/staybox/otus_dz28/master/screenshots/django.png) 

## Как запустить:
 - ```git clone git@github.com:staybox/otus_dz28.git && cd otus_dz28 && vagrant up```

## Как проверить работоспособность:
Можно перейти по ссылкам после разворачивания стенда: 
- http://192.168.100.20:83 
- http://192.168.100.20:82 
- http://192.168.100.20:81 

---
