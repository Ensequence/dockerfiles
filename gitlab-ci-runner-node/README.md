# gitlab-ci-runner-node


### install

    docker pull weisjohn/gitlab-ci-runner-node

### usage

First, you must register your runner via.

    % docker run \
        -e CI_SERVER_URL=https://ci.example.com \
        -e REGISTRATION_TOKEN=replaceme \
        -e HOME=/root \
        -e GITLAB_SERVER_FQDN=gitlab.example.com \
        -i -t \
        weisjohn/gitlab-ci-runner-node /bin/bash

You'll be connected to an interactive terminal session, where you can enter in the following command, which will register the runner and cache the IP for your instance of Gitlab.

```
$ ssh-keyscan -H $GITLAB_SERVER_FQDN >> /root/.ssh/known_hosts && bundle exec ./bin/setup_and_run
$ exit
```

In the bash prompt, you'll see the container ID that you need to commit, something like: `root@0144cab49492:/gitlab-ci-runner#`, the `0144cab49492` is the number you need (yours will be different).

    $ docker commit 0144cab49492 gitlab-ci-runner-node

You can then stop the original container and run the new named container. This new container will remember the previous configuration.

    $ docker run -d gitlab-ci-runner-node
