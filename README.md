# Dockerized Ansible command line tools

> Use Ansible command line tools inside Docker in CI or Local Environment.

## Supported tags and respective `Dockerfile` links

* [`latest`](https://github.com/gadiener/ansible/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/gdiener/ansible:latest.svg)](http://microbadger.com/images/gdiener/ansible:latest)
* [`1`, `1.0`, `1.0.0`](https://github.com/gadiener/ansible/blob/1.0.0/Dockerfile) [![](https://images.microbadger.com/badges/image/gdiener/ansible:1.svg)](http://microbadger.com/images/gdiener/ansible:1)

## How to use

### Docker run

* [ansible](https://docs.ansible.com/ansible/2.5/cli/ansible.html): Define and run a single task ‘playbook’ against a set of hosts.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible all -m ping
```

* [ansible-playbook](https://docs.ansible.com/ansible/2.5/cli/ansible-playbook.html): Runs Ansible playbooks, executing the defined tasks on the targeted hosts.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-playbook site.yml
```

* [ansible-vault](https://docs.ansible.com/ansible/2.5/cli/ansible-vault.html): Encryption/decryption utility for Ansible data files.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-vault encrypt_string
```

* [ansible-galaxy](https://docs.ansible.com/ansible/2.5/cli/ansible-galaxy.html):  Manage Ansible roles in shared repositories

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-galaxy login
```

* [ansible-console](https://docs.ansible.com/ansible/2.5/cli/ansible-console.html): A REPL that allows for running ad-hoc tasks against a chosen inventory.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-console
```

* [ansible-config](https://docs.ansible.com/ansible/2.5/cli/ansible-config.html): Config command line class.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-config dump
```

* [ansible-doc](https://docs.ansible.com/ansible/2.5/cli/ansible-doc.html): Plugin documentation tool.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-doc file
```

* [ansible-inventory](https://docs.ansible.com/ansible/2.5/cli/ansible-inventory.html): Display or dump the configured inventory as Ansible sees it.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-inventory --host localhost
```

* [ansible-pull](https://docs.ansible.com/ansible/2.5/cli/ansible-pull.html): Pulls playbooks from a VCS repo and executes them for the local host.

```bash
docker run -v $(pwd):/workspace/ -it gdiener/ansible ansible-pull -U git@github.com:gadiener/unknown-ansible-repository.git site.yml
```

⁉️ *This command is useless in the Docker context but you can still do it* 😄

### Add shell aliases

To install the aliases script you can use the following commands:

```bash
curl -o /usr/local/bin/ansible-aliases https://raw.githubusercontent.com/gadiener/ansible/master/ansible-aliases.sh
chmod +x /usr/local/bin/ansible-aliases
```

Then you can use the script.

```bash
$ ansible-aliases -h

Usage: ansible-aliases [OPTIONS]

>> Install dockerized Ansible tools aliases

Options:
   -k, --key string         The path of the SSH key to use
   -w, --workspace string   The path of the workspace to use (default $(pwd))
   -t, --tag string         The Docker tag to use
   -e, --env string         Set environment variables
       --remove             Uninstall Ansible aliases
```

```bash
ansible-aliases -k $SSH_KEY_PATH -e 'ANSIBLE_HOST_KEY_CHECKING=False'
```

After installing the aliases, the shell must be restarted.

To remove aliases you can use the following commands:

```bash
ansible-aliases --remove
rm /usr/local/bin/ansible-aliases
```

## Configuration

### Environment variables

The SSH_KEY variable must contains che SSH key used by Ansible to connect to the cluster.

```Bash
SSH_KEY=$(cat ~/.ssh/id_rsa)
```

### Volumes

To share your tasks or playbook's files you can bind a volume to `/workspace`.

You can bind a volume to `/etc/ansible` to share your local conficuration with Ansible in docker.

**⛔️ WARNING: Do not add a volume in `~/.ssh/:/home/ansible/.ssh/` without the read-only flag. With the environment variable `SSH_KEY` set you'll lose your private key!**

### Use it in GitLab CI

@todo: I'm waiting for your pull request 😉

## Contributing

How to get involved:

1. [Star](https://github.com/gadiener/docker-mariadb-replication/stargazers) the project!
2. Answer questions that come through [GitHub issues](https://github.com/gadiener/docker-mariadb-replication/issues?state=open)
3. [Report a bug](https://github.com/gadiener/docker-mariadb-replication/issues/new) that you find

This project follows the [GitFlow branching model](http://nvie.com/posts/a-successful-git-branching-model). The ```master``` branch always reflects a production-ready state while the latest development is taking place in the ```develop``` branch.

Each time you want to work on a fix or a new feature, create a new branch based on the ```develop``` branch: ```git checkout -b BRANCH_NAME develop```. Only pull requests to the ```develop``` branch will be merged.

Pull requests are **highly appreciated**.

Solve a problem. Features are great, but even better is cleaning-up and fixing issues in the code that you discover.

### Versioning

This project is maintained by using the [Semantic Versioning Specification (SemVer)](http://semver.org).

### Contributors

Gabriele Diener [@gadiener](https://github.com/gadiener)

Flavio De Stefano [@kopiro](https://github.com/kopiro)

## Copyright and license

Copyright 2018 [Gabriele Diener](https://gdiener.com) under the [MIT license](LICENSE.md).