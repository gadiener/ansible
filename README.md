# Dockerized Ansible command line tools

> Use Ansible command line tools inside Docker in CI or Local Environment.

## How to use

### Docker run

```bash
docker run -e "SSH_KEY=$(cat ~/.ssh/id_rsa)" -v $(pwd):/playbook/ -it gdiener/ansible all -m ping
```

```bash
docker run -e "SSH_KEY=$(cat ~/.ssh/id_rsa)" -v $(pwd):/playbook/ -it gdiener/ansible ansible-playbook site.yml
```

## Configuration

@TODO

### Shell aliases

@TODO

### Volumes

@TODO

### Enviroment variables

@TODO

```Bash
ANSIBLE_HOST_KEY_CHECKING=False
SSH_KEY=$(cat ~/.ssh/id_rsa)
```

### GitLab CI

@TODO

## Contributing

How to get involved:

1. [Star](https://github.com/gadiener/docker-mariadb-replication/stargazers) the project!
2. Answer questions that come through [GitHub issues](https://github.com/gadiener/docker-mariadb-replication/issues?state=open)
3. [Report a bug](https://github.com/gadiener/docker-mariadb-replication/issues/new) that you find

This project follows the [GitFlow branching model](http://nvie.com/posts/a-successful-git-branching-model). The ```master``` branch always reflects a production-ready state while the latest development is taking place in the ```develop``` branch.

Each time you want to work on a fix or a new feature, create a new branch based on the ```develop``` branch: ```git checkout -b BRANCH_NAME develop```. Only pull requests to the ```develop``` branch will be merged.

Pull requests are **highly appreciated**.

Solve a problem. Features are great, but even better is cleaning-up and fixing issues in the code that you discover.


## Versioning

This project is maintained by using the [Semantic Versioning Specification (SemVer)](http://semver.org).


## Copyright and license

Copyright 2017 [Gabriele Diener](https://gdiener.com) under the [MIT license](LICENSE.md).