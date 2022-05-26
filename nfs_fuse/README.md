# NFS

Проверяем конфиг Vagranta

```
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
    v.memory = 256
    v.cpus = 1
  end
  config.vm.define "nfss" do |nfss|
    nfss.vm.network "private_network", ip: "192.168.10.10", virtualbox__intnet: "net1"
    nfss.vm.hostname = "nfss"
    nfss.vm.provision "shell", path: "nfss_script.sh"
  end
  config.vm.define "nfsc" do |nfsc|
    nfsc.vm.network "private_network", ip: "192.168.10.11", virtualbox__intnet: "net1"
    nfsc.vm.hostname = "nfsc"
    nfsc.vm.provision "shell", path: "nfsc_script.sh"
  end
end
```
Запускаем
```
vagrant up
```
Дождитесь завершения работы vagrant, после чего у нас досупен сервре nfs и клиент.

Далее используем команды для проверки.
На сервере:

```
cd /srv/share/upload/
touch 123
ll
```
На клиенте:
```
mount | grep mnt
cd /mnt/share/upload/
ll
touch 123456
```


