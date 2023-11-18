
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
```


- `files/`: directory containing templates and other files required by the playbook.
- `vars/`: directory to save variable files. A `default.yml` var file is included by default.
- `playbook.yml`: the playbook file.
- `readme.md`: instructions and links related to this playbook.

##Running this playbook will perform the following actions on your Ansible hosts:

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


