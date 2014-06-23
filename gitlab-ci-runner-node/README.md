# gitlab-ci-runner-node


### install

    docker pull weisjohn/gitlab-ci-runner-node

### usage

First, register your worker via:

    % docker run -d \
        -e CI_SERVER_URL=https://ci.example.com \
        -e REGISTRATION_TOKEN=replaceme \
        -e HOME=/root \
        -e GITLAB_SERVER_FQDN=gitlab.example.com \
        weisjohn/gitlab-ci-runner-node

Trigger a build in your Gitlab CI, then, take a snapshot of your registered runner container.