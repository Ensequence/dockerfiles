# gitlab-ci-runner-node


### install

    docker pull weisjohn/gitlab-ci-runner-nodejs

### usage

    % docker run -d \
        -e CI_SERVER_URL=https://ci.example.com \
        -e REGISTRATION_TOKEN=replaceme \
        -e HOME=/root \
        -e GITLAB_SERVER_FQDN=gitlab.example.com \
        weisjohn/gitlab-ci-runner-nodejs