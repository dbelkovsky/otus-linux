1. Cпособ действует только для пользователя, здесь нельзя указать группу, в которую входит пользователь.
Чтобы у пользователя не было возможности войти в систему не только через SSH, а также через обычную консоль, то необходимо откорректировать два файла.

- Правим конфиг: /etc/pam.d/sshd

```
[root@usermod]# vi /etc/pam.d/sshd
#%PAM-1.0
auth       required     pam_sepermit.so
auth       substack     password-auth
auth       include      postlogin
# Used with polkit to reauthorize users in remote sessions
-auth      optional     pam_reauthorize.so prepare
account required pam_access.so # Это модуль, который может давать доступ одной группе и не давать другой, но он не может это сделать по дням и времени
account required pam_time.so # Добавляем вот эту строку для ограничения по пользователю
account    required     pam_nologin.so
account    include      password-auth
password   include      password-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      password-auth
session    include      postlogin
# Used with polkit to reauthorize users in remote sessions
-session   optional     pam_reauthorize.so prepare
```

- Правим конфиг: /etc/pam.d/login

```
[root@usermod]# vi /etc/pam.d/login
#%PAM-1.0
auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
auth       substack     system-auth
auth       include      postlogin
account required pam_access.so # Это модуль, который может давать доступ одной группе и не давать другой, но он не может это сделать по дням и времени
account   required   pam_time.so # Добавляем вот эту строку для ограничения по пользователю
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
session    optional     pam_console.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    include      postlogin
-session   optional     pam_ck_connector.so
```

- Затем vi /etc/security/time.conf и добавляем в конце файла строку

*;*;user1;!Tu

- Перезагружаем сервис ssh для более быстрого принятия изменений в конфиге:

systemctl restart sshd

- Создаем пользователя командой:

useradd user1

- Задаем пароль командой:

passwd 132

- Пытаемся зайти в тот день, когда у нас работает правило и получаем:
```
[root@usermod]# ssh user1@localhost
user1@localhost's password:
Authentication failed.
```
2. Не сложно добавить права пользователю для управления докером.
нужно добавить его в группу docker и сделать релогин и тогда он сможет рестартовать и запускать докер.
```
usermod -aG docker user1
cat /etc/group | grep docker
docker:x:998:user1

logout
login
```
