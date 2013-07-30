# dockerfiles

> A collection of dockerfiles to create containers

[Docker](http://docker.io) is an open source project to pack, ship and run any application as a lightweight container. These *dockerfiles* build containers that can be run almost anywhere with isolation and repeatability guarentees.


### docker

If you're convinced to use docker already, and __you are using Mac OSX__, you can simply install using the `install_docker.sh` script. This will install docker (and all dependencies) into your `~/src/docker` folder and then bring up the VM.  You can clone this repo and run the `install_docker.sh` script:

```
$ git clone https://github.com/Ensequence/dockerfiles.git && cd dockerfiles
$ ./install_docker.sh
```

Alternatively, you can cURL and install right away:

```
$ curl https://raw.github.com/Ensequence/dockerfiles/master/install_docker.sh -s | bash
```

Then, you can connect to that VM via:

```
$ cd ~/src/docker
$ vagrant ssh
```

From there, you can install images (`docker pull`) or run images / containers (`docker run`)...


## Images

### gitlab-ci-runner

Gitlab CI is an awesome project for continuous integration.  We use it to automatically buid software as it's modified through the lifetime of the project.  One benefit of Gitlab CI is it doesn't run the builds on the CI server itself.  It allows you to register *runners* on other machines.  All of our developer machines then can register as runners to run builds. 

Documentation to [download and install this image can be found here](gitlab-ci-runner/README.md).

