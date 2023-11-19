# Wordpress on Ubuntu 18.04 LAMP

This playbook will install a WordPress website on top of a LAMP environment (**L**inux, **A**pache, **M**ySQL and **P**HP) on an Ubuntu 18.04 machine.A virtualhost will be created with the options specified in the `vars/<environmnet-file>.yml` variable file.

## Settings

- `php_modules`:  An array containing PHP extensions that should be installed to support your WordPress setup. You don't need to change this variable, but you might want to include new extensions to the list if your specific setup requires it.
- `mysql_root_password`: The desired password for the **root** MySQL account.
- `mysql_db`: The name of the MySQL database that should be created for WordPress.
- `mysql_user`: The name of the MySQL user that should be created for WordPress.
- `mysql_password`: The password for the new MySQL user.
- `http_host`: Your domain name.
- `http_conf`: The name of the configuration file that will be created within Apache.
- `http_port`: HTTP port for this virtual host, where `80` is the default. 

## Playbook Structure

```
Wordpress,LAMP (Linux, Apache, MySQL and PHP) stacks installation on ubuntu1804
wordpress-lamp_ubuntu1804
├── files
│   ├── apache.conf.j2
│   └── nwp-config.php.j2
├── vars
│   └── default.yml
├── playbook.yml
└── readme.md

- `files/`: directory containing templates and other files required by the playbook.
- `vars/`: directory to save variable files. A `default.yml` var file is included by default.
- `playbook.yml`: the playbook file.
- `readme.md`: instructions and links related to this playbook.

```

## Running this Playbook

Quickstart guide for those already familiar with Ansible:

### 1. Obtain the playbook
```shell
https://github.com/532629/Wordpress-migration.git
cd ansible/ansible-playbooks/wordpress-lamp_ubuntu1804
```

### 2. Customize Options

```shell
vi vars/default.yml
```

```yml
---
#System Settings
php_modules: [ 'php-curl', 'php-gd', 'php-mbstring', 'php-xml', 'php-xmlrpc', 'php-soap', 'php-intl', 'php-zip' ]

#MySQL Settings
mysql_root_password: "mysql_root_password"
mysql_db: "wordpress"
mysql_user: "sammy"
mysql_password: "password"

#HTTP Settings
http_host: "your_domain"
http_conf: "your_domain.conf"
http_port: "80"
```

### 3. Run the Playbook

```command
NB - Passing the environment variable file to ansible-playbook using "extra-vars"
ansible-playbook  playbook.yml -l [target] -i [inventory file] -u [remote user] 
ansible-playbook playbook.yml -l wpserver-preprod -u wp --extra-vars "variable_file=preprod"  -vvv
```
``` 
PLAY [all] ***********************************************************************************************************************************************************************************************************
 
TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************
ok: [prod]
 
TASK [Install prerequisites] *****************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Install LAMP Packages] *****************************************************************************************************************************************************************************************
changed: [prod] => (item=apache2)
changed: [prod] => (item=mysql-server)
changed: [prod] => (item=python3-pymysql)
changed: [prod] => (item=php)
changed: [prod] => (item=php-mysql)
changed: [prod] => (item=libapache2-mod-php)
 
TASK [Install PHP Extensions] ****************************************************************************************************************************************************************************************
changed: [prod] => (item=php-curl)
changed: [prod] => (item=php-gd)
changed: [prod] => (item=php-mbstring)
changed: [prod] => (item=php-xml)
changed: [prod] => (item=php-xmlrpc)
changed: [prod] => (item=php-soap)
changed: [prod] => (item=php-intl)
changed: [prod] => (item=php-zip)
changed: [prod] => (item=php-bcmath)
changed: [prod] => (item=php-imagick)
changed: [prod] => (item=php-json)
 
TASK [Create document root] ******************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set up Apache VirtualHost] *************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Enable rewrite module] *****************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Enable new site] ***********************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Disable default Apache site] ***********************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set the root password] *****************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Remove all anonymous user accounts] ****************************************************************************************************************************************************************************
ok: [prod]
 
TASK [Remove the MySQL test database] ********************************************************************************************************************************************************************************
ok: [prod]
 
TASK [Creates database for WordPress] ********************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Create MySQL user for WordPress] *******************************************************************************************************************************************************************************
changed: [prod]
 
TASK [UFW - Allow HTTP on port 80] ***********************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Download and unpack latest WordPress] **************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set ownership] *************************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set permissions for directories] *******************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set permissions for files] *************************************************************************************************************************************************************************************
changed: [prod]
 
TASK [Set up wp-config] **********************************************************************************************************************************************************************************************
changed: [prod]
 
RUNNING HANDLER [Reload Apache] **************************************************************************************************************************************************************************************
changed: [prod]
 
RUNNING HANDLER [Restart Apache] *************************************************************************************************************************************************************************************
changed: [prod]
 
PLAY RECAP ***********************************************************************************************************************************************************************************************************
prod                       : ok=22   changed=19   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

## Running this playbook will perform the following actions on your Ansible hosts:

- Install aptitude, which is preferred by Ansible as an alternative to the apt package manager.
- Install the required LAMP packages and PHP extensions.
- Create and enable a new Apache VirtualHost for the WordPress website.
- Enable the Apache rewrite (mod_rewrite) module.
- Disable the default Apache website.
- Set the password for the MySQL root user.
- Remove anonymous MySQL accounts and the test database.
- Create a new MySQL database and user for the WordPress website.
- Set up UFW to allow HTTP traffic on the configured port (80 by default).
- Download and unpack WordPress.
- Set up correct directory ownership and permissions.
- Set up the wp-config.php file using the provided template.


