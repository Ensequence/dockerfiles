# dockerfiles

> A collection of dockerfiles to create containers

[Docker](http://docker.io) is an open source project to pack, ship and run any application as a lightweight container. These *dockerfiles* build containers that can be run almost anywhere with isolation and repeatability guarentees.


### gitlab-ci-runner

Gitlab CI is an awesome project for continuous integration.  We use it to automatically buid software as it's modified through the lifetime of the project.  One benefit of Gitlab CI is it doesn't run the builds on the CI server itself.  It allows you to register *runners* on other machines.  All of our developer machines then can register as runners to run builds. 

Documentation to [download and install this image can be found here](gitlab-ci-runner/README.md).

