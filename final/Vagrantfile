Vagrant.configure("2") do |config|

config.vm.define "percona3" do |percona3|

percona3.vm.box = "centos/7"

    percona3.vm.network "private_network", ip: "192.168.10.57"

    percona3.vm.hostname = "percona3"

    percona3.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "512"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    percona3.vm.provision "file", source: "./files/percona3/wsrep.cnf", destination: "/tmp/wsrep.cnf"

    percona3.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       timedatectl set-timezone Europe/Moscow

cat <<EOF >> /etc/hosts
192.168.10.55 percona1
192.168.10.56 percona2
192.168.10.57 percona3
EOF

       yum install epel-release -y; yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; yum install ntp yum-utils nano wget -y && systemctl start ntpd && systemctl enable ntpd; yum install audit audispd-plugins policycoreutils-python -y

       yum install Percona-XtraDB-Cluster-57 sshpass -y; 
       
       mv /etc/percona-xtradb-cluster.conf.d/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf.bak; mv /tmp/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
       
       sudo chown root:root /etc/percona-xtradb-cluster.conf.d/wsrep.cnf; sudo chmod 644 /etc/percona-xtradb-cluster.conf.d/wsrep.cnf;
       
       systemctl enable mysql && systemctl start mysql; sleep 10; sshpass -p "vagrant" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.10.55 "sudo systemctl stop mysql@bootstrap.service; sudo systemctl start mysql";


    SHELL

end

config.vm.define "percona2" do |percona2|

percona2.vm.box = "centos/7"

    percona2.vm.network "private_network", ip: "192.168.10.56"

    percona2.vm.hostname = "percona2"

    percona2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "512"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    percona2.vm.provision "file", source: "./files/percona2/wsrep.cnf", destination: "/tmp/wsrep.cnf"

    percona2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       yum install epel-release -y; yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; yum install ntp yum-utils nano wget -y && systemctl start ntpd && systemctl enable ntpd; yum install audit audispd-plugins policycoreutils-python -y

       yum install Percona-XtraDB-Cluster-57 -y; 

       mv /etc/percona-xtradb-cluster.conf.d/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf.bak; mv /tmp/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf
       
       sudo chown root:root /etc/percona-xtradb-cluster.conf.d/wsrep.cnf; sudo chmod 644 /etc/percona-xtradb-cluster.conf.d/wsrep.cnf;
       
       systemctl enable mysql && systemctl start mysql

cat <<EOF >> /etc/hosts
192.168.10.55 percona1
192.168.10.56 percona2
192.168.10.57 percona3
EOF

    SHELL

end


config.vm.define "percona1" do |percona1|

percona1.vm.box = "centos/7"

    percona1.vm.network "private_network", ip: "192.168.10.55"

    percona1.vm.hostname = "percona1"

    percona1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "512"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    percona1.vm.provision "file", source: "./files/percona1/wsrep.cnf", destination: "/tmp/wsrep.cnf"

    percona1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; yum install ntp yum-utils nano wget -y && systemctl start ntpd && systemctl enable ntpd; yum install audit audispd-plugins policycoreutils-python -y

       sudo yum install Percona-XtraDB-Cluster-57 -y; 
       
       systemctl start mysql; systemctl enable mysql; password=$(cat /var/log/mysqld.log | grep 'root@localhost:' | awk '{print $11}'); echo -e "[client]\n\ruser=\"root\"\n\rpassword=\"$password\"" > /home/vagrant/my.cnf

       mysql --defaults-file=/home/vagrant/my.cnf  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'rootPass';" --connect-expired-password; systemctl stop mysql; password="rootPass"

       echo -e "[client]\n\ruser=\"root\"\n\rpassword=\"$password\"" > /home/vagrant/my.cnf

       mv /etc/percona-xtradb-cluster.conf.d/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf.bak; mv /tmp/wsrep.cnf /etc/percona-xtradb-cluster.conf.d/wsrep.cnf

       sudo chown root:root /etc/percona-xtradb-cluster.conf.d/wsrep.cnf; sudo chmod 644 /etc/percona-xtradb-cluster.conf.d/wsrep.cnf;

       systemctl start mysql@bootstrap.service; mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE USER 'sstuser'@'localhost' IDENTIFIED BY 's3cretPass';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "GRANT RELOAD, LOCK TABLES, PROCESS, REPLICATION CLIENT ON *.* TO 'sstuser'@'localhost';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "FLUSH PRIVILEGES;" --connect-expired-password

       curl -OL -o /home/vagrant/addition_to_sys.sql https://gist.github.com/lefred/77ddbde301c72535381ae7af9f968322/raw/5e40b03333a3c148b78aa348fd2cd5b5dbb36e4d/addition_to_sys.sql

       mysql --defaults-file=/home/vagrant/my.cnf < /home/vagrant/addition_to_sys.sql --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE USER 'admin-proxysql'@'%' IDENTIFIED BY 'rootPass';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE USER 'check-health'@'%' IDENTIFIED BY '';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf -e "GRANT ALL PRIVILEGES ON *.* to 'admin-proxysql'@'%' WITH GRANT OPTION;" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "FLUSH PRIVILEGES;" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE DATABASE wordpress;" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE USER 'monitor'@'192.%' IDENTIFIED BY 'monitor';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "GRANT SELECT on sys.* to 'monitor'@'192.%';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "CREATE USER 'play'@'192.%' IDENTIFIED BY 'play';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "GRANT ALL PRIVILEGES on wordpress.* to 'play'@'192.%';" --connect-expired-password

       mysql --defaults-file=/home/vagrant/my.cnf  -e "FLUSH PRIVILEGES;" --connect-expired-password

cat <<EOF >> /etc/hosts
192.168.10.55 percona1
192.168.10.56 percona2
192.168.10.57 percona3
EOF

    SHELL

end


config.vm.define "balancer3" do |balancer3|

balancer3.vm.box = "centos/7"

    balancer3.vm.network "private_network", ip: "192.168.10.52"

    balancer3.vm.hostname = "balancer3"

    balancer3.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    balancer3.vm.provision "file", source: "./files/keepalived-balancer3.conf", destination: "/tmp/keepalived.conf"

    balancer3.vm.provision "file", source: "./files/haproxy-balancer3_4.cfg", destination: "/tmp/haproxy.cfg"

    balancer3.vm.provision "file", source: "./files/keepalived.timer", destination: "/tmp/keepalived.timer"

    balancer3.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       yum install epel-release -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y; yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y;

       yum install keepalived haproxy yum-utils telnet nano mysql -y; yum install audit audispd-plugins policycoreutils-python -y; yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf; echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf; sysctl -w net.ipv4.ip_forward=1; sysctl -w net.ipv4.ip_nonlocal_bind=1;

       mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

       mv /tmp/keepalived.conf /etc/keepalived/keepalived.conf

       mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak

       mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg

       mv /tmp/keepalived.timer /etc/systemd/system/

       sudo chown root:root /etc/systemd/system/keepalived.timer; sudo chmod 644 /etc/systemd/system/keepalived.timer; 
    
       sudo chown root:root /etc/haproxy/haproxy.cfg; sudo chmod 644 /etc/haproxy/haproxy.cfg;

       sudo chown root:root /etc/keepalived/keepalived.conf; sudo chmod 644 /etc/keepalived/keepalived.conf; 
    
       systemctl daemon-reload; systemctl enable keepalived.timer; systemctl enable keepalived.service; systemctl start haproxy.service; systemctl start keepalived.service; systemctl enable haproxy.service;


cat <<EOF >> /etc/hosts
192.168.10.49 redis1
192.168.10.50 redis2
192.168.10.51 redis3
192.168.10.47 backend1
192.168.10.48 backend2
192.168.10.55 percona1
192.168.10.56 percona2
192.168.10.57 percona3
EOF


    SHELL

end

config.vm.define "balancer4" do |balancer4|

balancer4.vm.box = "centos/7"

    balancer4.vm.network "private_network", ip: "192.168.10.54"

    balancer4.vm.hostname = "balancer4"

    balancer4.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    balancer4.vm.provision "file", source: "./files/keepalived-balancer4.conf", destination: "/tmp/keepalived.conf"

    balancer4.vm.provision "file", source: "./files/haproxy-balancer3_4.cfg", destination: "/tmp/haproxy.cfg"

    balancer4.vm.provision "file", source: "./files/keepalived.timer", destination: "/tmp/keepalived.timer"

    balancer4.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       yum install epel-release -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y; yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y;

       yum install keepalived haproxy yum-utils telnet nano mysql -y; yum install audit audispd-plugins policycoreutils-python -y; yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf; echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf; sysctl -w net.ipv4.ip_forward=1; sysctl -w net.ipv4.ip_nonlocal_bind=1;

       mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

       mv /tmp/keepalived.conf /etc/keepalived/keepalived.conf

       mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak

       mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg

       mv /tmp/keepalived.timer /etc/systemd/system/

       sudo chown root:root /etc/systemd/system/keepalived.timer; sudo chmod 644 /etc/systemd/system/keepalived.timer; 
    
       sudo chown root:root /etc/haproxy/haproxy.cfg; sudo chmod 644 /etc/haproxy/haproxy.cfg;

       sudo chown root:root /etc/keepalived/keepalived.conf; sudo chmod 644 /etc/keepalived/keepalived.conf; 
    
       systemctl daemon-reload; systemctl enable keepalived.timer; systemctl enable keepalived.service; systemctl start haproxy.service; systemctl start keepalived.service; systemctl enable haproxy.service;


cat <<EOF >> /etc/hosts
192.168.10.49 redis1
192.168.10.50 redis2
192.168.10.51 redis3
192.168.10.47 backend1
192.168.10.48 backend2
192.168.10.55 percona1
192.168.10.56 percona2
192.168.10.57 percona3
EOF


    SHELL

end

config.vm.define "redis1" do |redis1|
    redis1.vm.box = "centos/7"

    redis1.vm.network "private_network", ip: "192.168.10.49"

    redis1.vm.hostname = "redis1"

    redis1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    redis1.vm.provision "file", source: "./files/redis/redis@.service", destination: "/tmp/redis@.service"

    redis1.vm.provision "file", source: "./files/redis/redis1/redis.conf", destination: "/tmp/redis.conf"

    redis1.vm.provision "file", source: "./files/redis/redis1/redis-sentinel.conf", destination: "/tmp/redis-sentinel.conf"

    redis1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

cat <<EOF >> /etc/hosts
192.168.10.49 redis1
192.168.10.50 redis2
192.168.10.51 redis3
192.168.10.47 backend1
192.168.10.48 backend2
EOF

       yum install audit audispd-plugins policycoreutils-python -y

       sudo yum-config-manager --enable remi; sudo yum install redis -y

       mv /tmp/redis@.service /etc/systemd/system; mv /tmp/redis.conf /etc/; mv /tmp/redis-sentinel.conf /etc/

       sudo chown redis:root /etc/redis.conf; sudo chmod 640 /etc/redis.conf; sudo chown redis:root /etc/redis-sentinel.conf; sudo chmod 640 /etc/redis-sentinel.conf; sudo chown root:root /etc/systemd/system/redis@.service; sudo chmod 644 /etc/systemd/system/redis@.service

       echo "vm.overcommit_memory=1" >> /etc/sysctl.conf

       echo "net.core.somaxconn=512" >> /etc/sysctl.conf

       echo "fs.file-max=150000" >> /etc/sysctl.conf

       sysctl -w vm.overcommit_memory=1; sysctl -w net.core.somaxconn=512; sysctl -w fs.file-max=150000

       systemctl daemon-reload; systemctl enable redis@redis && systemctl start redis@redis; systemctl enable redis-sentinel.service && systemctl start redis-sentinel.service

    SHELL

    end

config.vm.define "redis2" do |redis2|
    redis2.vm.box = "centos/7"

    redis2.vm.network "private_network", ip: "192.168.10.50"

    redis2.vm.hostname = "redis2"

    redis2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    redis2.vm.provision "file", source: "./files/redis/redis@.service", destination: "/tmp/redis@.service"

    redis2.vm.provision "file", source: "./files/redis/redis2/redis.conf", destination: "/tmp/redis.conf"

    redis2.vm.provision "file", source: "./files/redis/redis2/redis-sentinel.conf", destination: "/tmp/redis-sentinel.conf"

    redis2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

cat <<EOF >> /etc/hosts
192.168.10.49 redis1
192.168.10.50 redis2
192.168.10.51 redis3
192.168.10.47 backend1
192.168.10.48 backend2
EOF

       yum install audit audispd-plugins policycoreutils-python -y

       sudo yum-config-manager --enable remi; sudo yum install redis -y

       mv /tmp/redis@.service /etc/systemd/system; mv /tmp/redis.conf /etc/; mv /tmp/redis-sentinel.conf /etc/

       sudo chown redis:root /etc/redis.conf; sudo chmod 640 /etc/redis.conf; sudo chown redis:root /etc/redis-sentinel.conf; sudo chmod 640 /etc/redis-sentinel.conf; sudo chown root:root /etc/systemd/system/redis@.service; sudo chmod 644 /etc/systemd/system/redis@.service

       echo "vm.overcommit_memory=1" >> /etc/sysctl.conf

       echo "net.core.somaxconn=512" >> /etc/sysctl.conf

       echo "fs.file-max=150000" >> /etc/sysctl.conf

       sysctl -w vm.overcommit_memory=1; sysctl -w net.core.somaxconn=512; sysctl -w fs.file-max=150000

       systemctl daemon-reload; systemctl enable redis@redis && systemctl start redis@redis; systemctl enable redis-sentinel.service && systemctl start redis-sentinel.service

    SHELL

    end

    config.vm.define "redis3" do |redis3|
    redis3.vm.box = "centos/7"

    redis3.vm.network "private_network", ip: "192.168.10.51"

    redis3.vm.hostname = "redis3"

    redis3.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end
    
    redis3.vm.provision "file", source: "./files/redis/redis@.service", destination: "/tmp/redis@.service"

    redis3.vm.provision "file", source: "./files/redis/redis3/redis.conf", destination: "/tmp/redis.conf"

    redis3.vm.provision "file", source: "./files/redis/redis3/redis-sentinel.conf", destination: "/tmp/redis-sentinel.conf"

    redis3.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config; setenforce 0

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

cat <<EOF >> /etc/hosts
192.168.10.49 redis1
192.168.10.50 redis2
192.168.10.51 redis3
192.168.10.47 backend1
192.168.10.48 backend2
EOF

       yum install audit audispd-plugins policycoreutils-python -y

       sudo yum-config-manager --enable remi; sudo yum install redis -y

       mv /tmp/redis@.service /etc/systemd/system; mv /tmp/redis.conf /etc/; mv /tmp/redis-sentinel.conf /etc/

       sudo chown redis:root /etc/redis.conf; sudo chmod 640 /etc/redis.conf; sudo chown redis:root /etc/redis-sentinel.conf; sudo chmod 640 /etc/redis-sentinel.conf; sudo chown root:root /etc/systemd/system/redis@.service; sudo chmod 644 /etc/systemd/system/redis@.service

       echo "vm.overcommit_memory=1" >> /etc/sysctl.conf

       echo "net.core.somaxconn=512" >> /etc/sysctl.conf

       echo "fs.file-max=150000" >> /etc/sysctl.conf

       sysctl -w vm.overcommit_memory=1; sysctl -w net.core.somaxconn=512; sysctl -w fs.file-max=150000

       systemctl daemon-reload; systemctl enable redis@redis && systemctl start redis@redis; systemctl enable redis-sentinel.service && systemctl start redis-sentinel.service

    SHELL

    end

config.vm.define "glusterfs1" do |glusterfs1|

    glusterfs1.vm.box = "centos/7"

    glusterfs1.vm.network "private_network", ip: "192.168.10.44"

    glusterfs1.vm.hostname = "glusterfs1"

    glusterfs1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    glusterfs1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       yum install epel-release centos-release-gluster nano wget zip unzip -y

       yum install glusterfs gluster-cli glusterfs-libs glusterfs-server samba -y

       sudo systemctl enable glusterd && sudo systemctl start glusterd

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       yum install audit audispd-plugins policycoreutils-python -y

cat <<EOF >> /etc/hosts
192.168.10.44 glusterfs1
192.168.10.45 glusterfs2
192.168.10.46 glusterfs3
EOF


    SHELL

    end

    config.vm.define "glusterfs2" do |glusterfs2|

    glusterfs2.vm.box = "centos/7"

    glusterfs2.vm.network "private_network", ip: "192.168.10.45"

    glusterfs2.vm.hostname = "glusterfs2"

    glusterfs2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    glusterfs2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       yum install epel-release centos-release-gluster nano wget -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       yum install glusterfs gluster-cli glusterfs-libs glusterfs-server samba -y

       sudo systemctl enable glusterd && sudo systemctl start glusterd

       yum install audit audispd-plugins policycoreutils-python -y

       cat <<EOF >> /etc/hosts
192.168.10.44 glusterfs1
192.168.10.45 glusterfs2
192.168.10.46 glusterfs3
EOF

    SHELL

    end

    config.vm.define "glusterfs3" do |glusterfs3|

    glusterfs3.vm.box = "centos/7"

    glusterfs3.vm.network "private_network", ip: "192.168.10.46"

    glusterfs3.vm.hostname = "glusterfs3"

    glusterfs3.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    glusterfs3.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       yum install epel-release centos-release-gluster nano wget -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       yum install glusterfs gluster-cli glusterfs-libs glusterfs-server samba -y

       sudo systemctl enable glusterd && sudo systemctl start glusterd

       yum install audit audispd-plugins policycoreutils-python -y

cat <<EOF >> /etc/hosts
192.168.10.44 glusterfs1
192.168.10.45 glusterfs2
192.168.10.46 glusterfs3
EOF

    SHELL

    end

    config.vm.define "balancer1" do |balancer1|

    balancer1.vm.box = "centos/7"

    balancer1.vm.network "private_network", ip: "192.168.10.40"

    balancer1.vm.hostname = "balancer1"

    balancer1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    balancer1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y

       yum install keepalived haproxy -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       yum install audit audispd-plugins policycoreutils-python nginx nano -y


    SHELL

    balancer1.vm.provision "file", source: "./files/keepalived-master.conf", destination: "/tmp/keepalived.conf"

    balancer1.vm.provision "file", source: "./files/haproxy.cfg", destination: "/tmp/haproxy.cfg"

    balancer1.vm.provision "file", source: "./files/keepalived.timer", destination: "/tmp/keepalived.timer"

    balancer1.vm.provision "shell", inline: <<-SHELL

    sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf; echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf; sysctl -w net.ipv4.ip_forward=1; sysctl -w net.ipv4.ip_nonlocal_bind=1;

    mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

    mv /tmp/keepalived.conf /etc/keepalived/keepalived.conf

    mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak

    mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg

    mv /tmp/keepalived.timer /etc/systemd/system/

    sudo chown root:root /etc/systemd/system/keepalived.timer; sudo chmod 644 /etc/systemd/system/keepalived.timer; 
    
    sudo chown root:root /etc/haproxy/haproxy.cfg; sudo chmod 644 /etc/haproxy/haproxy.cfg;

    sudo chown root:root /etc/keepalived/keepalived.conf; sudo chmod 644 /etc/keepalived/keepalived.conf; 
    
    systemctl daemon-reload; systemctl enable keepalived.timer; systemctl enable keepalived.service; systemctl start haproxy.service; systemctl start keepalived.service; systemctl enable haproxy.service;

    SHELL

    end

    config.vm.define "balancer2" do |balancer2|

      balancer2.vm.box = "centos/7"

      balancer2.vm.network "private_network", ip: "192.168.10.41"

      balancer2.vm.hostname = "balancer2"

      balancer2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end


      balancer2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y

       yum install keepalived haproxy -y

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       yum install audit audispd-plugins policycoreutils-python nginx nano -y

    SHELL

    balancer2.vm.provision "file", source: "./files/keepalived-slave.conf", destination: "/tmp/keepalived.conf"

    balancer2.vm.provision "file", source: "./files/haproxy.cfg", destination: "/tmp/haproxy.cfg"

    balancer2.vm.provision "file", source: "./files/keepalived.timer", destination: "/tmp/keepalived.timer"

    balancer2.vm.provision "shell", inline: <<-SHELL

    sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf; echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf; sysctl -w net.ipv4.ip_forward=1; sysctl -w net.ipv4.ip_nonlocal_bind=1;

    mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak

    mv /tmp/keepalived.conf /etc/keepalived/keepalived.conf

    mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak

    mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg

    mv /tmp/keepalived.timer /etc/systemd/system/

    sudo chown root:root /etc/systemd/system/keepalived.timer; sudo chmod 644 /etc/systemd/system/keepalived.timer; 
    
    sudo chown root:root /etc/haproxy/haproxy.cfg; sudo chmod 644 /etc/haproxy/haproxy.cfg;

    sudo chown root:root /etc/keepalived/keepalived.conf; sudo chmod 644 /etc/keepalived/keepalived.conf; 
    
    systemctl daemon-reload; systemctl enable keepalived.timer; systemctl enable keepalived.service; systemctl start haproxy.service; systemctl start keepalived.service; systemctl enable haproxy.service; 

    SHELL

    end

   config.vm.define "web1" do |web1|

    web1.vm.box = "centos/7"

    web1.vm.network "private_network", ip: "192.168.10.42"

    web1.vm.hostname = "web1"

    web1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    web1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install glusterfs-fuse nano -y

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       sudo yum check-update; sudo yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       sudo yum install nginx -y && systemctl enable nginx;


    SHELL

    web1.vm.provision "file", source: "./files/nginx.conf", destination: "/tmp/nginx.conf"

    web1.vm.provision "file", source: "./files/glusterfs.service", destination: "/tmp/glusterfs.service"

    web1.vm.provision "file", source: "./files/glusterfs.timer", destination: "/tmp/glusterfs.timer"

    web1.vm.provision "shell", inline: <<-SHELL

    mv /tmp/nginx.conf /etc/nginx/nginx.conf; mv /tmp/glusterfs.timer /etc/systemd/system/glusterfs.timer; mv /tmp/glusterfs.service /etc/systemd/system/glusterfs.service; 

    sudo chown root:root /etc/nginx/nginx.conf; sudo chmod 644 /etc/nginx/nginx.conf; sudo chown root:root /etc/systemd/system/glusterfs.timer; sudo chmod 644 /etc/systemd/system/glusterfs.timer; sudo chown root:root /etc/systemd/system/glusterfs.service; sudo chmod 644 /etc/systemd/system/glusterfs.service;  

    sudo systemctl daemon-reload; sudo systemctl enable glusterfs.timer
    
    sudo modprobe fuse

    mkdir /mnt/gluster; echo "192.168.10.44:/gv0 /mnt/gluster glusterfs _netdev 0 0" >> /etc/fstab; mount -a

    usermod -u 2000 nginx; groupmod -g 3000 nginx

    systemctl start nginx
    
    SHELL

    end

config.vm.define "web2" do |web2|

    web2.vm.box = "centos/7"

    web2.vm.network "private_network", ip: "192.168.10.43"

    web2.vm.hostname = "web2"

    web2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    web2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       yum install epel-release -y; yum install glusterfs-fuse nano -y

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       sudo yum check-update; sudo yum install ntp -y && systemctl start ntpd && systemctl enable ntpd

       sudo yum install nginx -y && systemctl enable nginx;


    SHELL

    web2.vm.provision "file", source: "./files/nginx.conf", destination: "/tmp/nginx.conf"

    web2.vm.provision "file", source: "./files/glusterfs.service", destination: "/tmp/glusterfs.service"

    web2.vm.provision "file", source: "./files/glusterfs.timer", destination: "/tmp/glusterfs.timer"

    web2.vm.provision "shell", inline: <<-SHELL

    mv /tmp/nginx.conf /etc/nginx/nginx.conf; mv /tmp/glusterfs.timer /etc/systemd/system/glusterfs.timer; mv /tmp/glusterfs.service /etc/systemd/system/glusterfs.service; 

    sudo chown root:root /etc/nginx/nginx.conf; sudo chmod 644 /etc/nginx/nginx.conf; sudo chown root:root /etc/systemd/system/glusterfs.timer; sudo chmod 644 /etc/systemd/system/glusterfs.timer; sudo chown root:root /etc/systemd/system/glusterfs.service; sudo chmod 644 /etc/systemd/system/glusterfs.service;  

    sudo systemctl daemon-reload; sudo systemctl enable glusterfs.timer
    
    modprobe fuse

    mkdir /mnt/gluster; echo "192.168.10.44:/gv0 /mnt/gluster glusterfs _netdev 0 0" >> /etc/fstab; mount -a

    usermod -u 2000 nginx; groupmod -g 3000 nginx

    systemctl start nginx

    SHELL

    end


config.vm.define "backend1" do |backend1|

    backend1.vm.box = "centos/7"

    backend1.vm.network "private_network", ip: "192.168.10.47"

    backend1.vm.hostname = "backend1"

    backend1.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    backend1.vm.provision "file", source: "./files/glusterfs.service", destination: "/tmp/glusterfs.service"

    backend1.vm.provision "file", source: "./files/glusterfs.timer", destination: "/tmp/glusterfs.timer"

    backend1.vm.provision "file", source: "./files/www.conf", destination: "/tmp/www.conf"

    backend1.vm.provision "file", source: "./files/php.ini", destination: "/tmp/php.ini"

    backend1.vm.provision "file", source: "./files/proxysql-admin.cnf", destination: "/tmp/proxysql-admin.cnf"

    backend1.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       mv /tmp/glusterfs.timer /etc/systemd/system/glusterfs.timer; mv /tmp/glusterfs.service /etc/systemd/system/glusterfs.service;

       sudo chown root:root /etc/systemd/system/glusterfs.timer; sudo chmod 644 /etc/systemd/system/glusterfs.timer; sudo chown root:root /etc/systemd/system/glusterfs.service; sudo chmod 644 /etc/systemd/system/glusterfs.service;  

       sudo systemctl daemon-reload; sudo systemctl enable glusterfs.timer

       yum install epel-release -y; yum install glusterfs-fuse -y; modprobe fuse; mkdir /mnt/gluster; echo "192.168.10.44:/gv0 /mnt/gluster glusterfs _netdev 0 0" >> /etc/fstab; mount -a
       
       yum install yum-utils telnet nano -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y; yum-config-manager --enable remi-php72 -y

       yum install php72 php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache php72-php-pecl-redis5.x86_64 -y 

       yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; yum install proxysql2 mysql -y; systemctl enable proxysql.service && systemctl start proxysql.service

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd
       
       useradd -u 2000 -s /sbin/nologin nginx; groupmod -g 3000 nginx; usermod -a -G nginx apache

       mv /tmp/www.conf /etc/opt/remi/php72/php-fpm.d/www.conf; mv /tmp/php.ini /etc/opt/remi/php72/php.ini; chown root:root /etc/opt/remi/php72/php-fpm.d/www.conf; chown root:root /etc/opt/remi/php72/php.ini; sudo chmod 644 /etc/opt/remi/php72/php-fpm.d/www.conf; sudo chmod 644 /etc/opt/remi/php72/php.ini;  

       mv /tmp/proxysql-admin.cnf /etc/proxysql-admin.cnf; sudo chown root:proxysql /etc/proxysql-admin.cnf; sudo chmod 640 /etc/proxysql-admin.cnf;
       
       systemctl enable php72-php-fpm.service && systemctl start php72-php-fpm.service

       echo n | sudo proxysql-admin --config-file=/etc/proxysql-admin.cnf --enable && sudo /usr/bin/proxysql-admin --syncusers


    SHELL

    end

    config.vm.define "backend2" do |backend2|

    backend2.vm.box = "centos/7"

    backend2.vm.network "private_network", ip: "192.168.10.48"

    backend2.vm.hostname = "backend2"

    backend2.vm.provider :virtualbox do |vb|

      vb.customize ["modifyvm", :id, "--memory", "256"]

      vb.customize ["modifyvm", :id, "--cpus", "2"]

      end

    backend2.vm.provision "file", source: "./files/glusterfs.service", destination: "/tmp/glusterfs.service"

    backend2.vm.provision "file", source: "./files/glusterfs.timer", destination: "/tmp/glusterfs.timer"

    backend2.vm.provision "file", source: "./files/www.conf", destination: "/tmp/www.conf"

    backend2.vm.provision "file", source: "./files/php.ini", destination: "/tmp/php.ini"

    backend2.vm.provision "file", source: "./files/proxysql-admin.cnf", destination: "/tmp/proxysql-admin.cnf"

    backend2.vm.provision "shell", inline: <<-SHELL

       mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh

       sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

       systemctl restart sshd

       timedatectl set-timezone Europe/Moscow

       sudo setenforce 0; sudo sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

       mv /tmp/glusterfs.timer /etc/systemd/system/glusterfs.timer; mv /tmp/glusterfs.service /etc/systemd/system/glusterfs.service;

       sudo chown root:root /etc/systemd/system/glusterfs.timer; sudo chmod 644 /etc/systemd/system/glusterfs.timer; sudo chown root:root /etc/systemd/system/glusterfs.service; sudo chmod 644 /etc/systemd/system/glusterfs.service;  

       sudo systemctl daemon-reload; sudo systemctl enable glusterfs.timer

       yum install epel-release -y; yum install glusterfs-fuse -y; modprobe fuse; mkdir /mnt/gluster; echo "192.168.10.44:/gv0 /mnt/gluster glusterfs _netdev 0 0" >> /etc/fstab; mount -a
       
       yum install yum-utils telnet nano -y; yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y; yum-config-manager --enable remi-php72 -y

       yum install php72 php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache php72-php-pecl-redis5.x86_64 -y 

       yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; yum install proxysql2 mysql -y; systemctl enable proxysql.service && systemctl start proxysql.service

       yum install ntp -y && systemctl start ntpd && systemctl enable ntpd
       
       useradd -u 2000 -s /sbin/nologin nginx; groupmod -g 3000 nginx; usermod -a -G nginx apache

       mv /tmp/www.conf /etc/opt/remi/php72/php-fpm.d/www.conf; mv /tmp/php.ini /etc/opt/remi/php72/php.ini; chown root:root /etc/opt/remi/php72/php-fpm.d/www.conf; chown root:root /etc/opt/remi/php72/php.ini; sudo chmod 644 /etc/opt/remi/php72/php-fpm.d/www.conf; sudo chmod 644 /etc/opt/remi/php72/php.ini;  

       mv /tmp/proxysql-admin.cnf /etc/proxysql-admin.cnf; sudo chown root:proxysql /etc/proxysql-admin.cnf; sudo chmod 640 /etc/proxysql-admin.cnf;

       echo n | sudo proxysql-admin --config-file=/etc/proxysql-admin.cnf --enable && sudo /usr/bin/proxysql-admin --syncusers
       
       systemctl enable php72-php-fpm.service && systemctl start php72-php-fpm.service


    SHELL

    end

end


