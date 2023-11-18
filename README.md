# WP Migration

Wordpress Application is core application for organization's marketing and pre-salse teams which needs to be available 24 by 7. As I see, Now a day, multiple organizations migrating their Wordpress applications from On-Prem to cloud, Public Hosting services company to company's hosted cloud servers.
This migration process is tedious and repeatative process, hence required a lot of time. Here, I have done wordpressp migration process automatically, starting from creating a cloud resources, installation of required runtimes (software packages,webservers, extensions etc...), configuration of wordpress servers, Database servers etc...

I have migrated 100's of small, mid and big sizes of  wordpress applications and sharing my learnings and experience here.

I have used following tools for this orchestrations.

1. Terraform scripts - For creating the Azure cloud resources. (Can change this scripts for other cloud services like - Google Cloud (GCP), AWS, Openstack etc...)
2. Ansible scripts - For configuration managements.
3. Wordpress All-in-plugings
     
Using these orchestration scripts, wordpress administrator can migrate any wordpress application with in just 30 minutes which may tooks weeks or so...

## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://github.com/532629/Wordpress-migration.git
git branch -M main
git push -uf origin main
```

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***
## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## Scripts need to be execute in following orders
- [ ] Run the Terraform script (It will create the required Azure cloud infrastructure)

```
cd terraform.
Please refer the README file for commands.
```

- [ ] Run the Ansible script ( It will install of required runtimes - software packages, webservers, extensions etc.., configure the wordpress servers, apache web server, Database servers etc...

```
cd ansible/ansible-playbooks/wordpress-lamp_ubuntu1804
Please refer the README file for commands.

```
