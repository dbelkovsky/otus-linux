1. Создаем роль: ansible-galaxy init roles/nginx.

2. В соответствии с методичкой приводим все к нужному виду.

3. Создаем playbook/nginx.yml, в котором указываем вызов нашей роли.

4. Запускаем его: ansible-playbook playbook/nginx.yml.

5. После запуска этого файла, вызывается файл /roles/nginx/tasks/main.yml.

6. Файл ansible.cfg помещаем с Vagrantfile в одну директорию.

7. Для запуска выполнить vagrant up
