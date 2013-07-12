
# gitlab-ci-runner


### 1. Installation and SSH Setup

Pull image and configure: 

 - Enter the URL of your Gitlab CI (ex: `http://192.168.1.1:8080/`)
 - Leave the passphrase blank.
 - SSH key location has already been specified (this is intentional)

```bash
$ docker pull weisjohn/gitlab-ci-runner
$ docker run -i -t weisjohn/gitlab-ci-runner /gcr/bin/install
Please type gitlab-ci url (Ex. http://gitlab-ci.org:3000/ )
http://192.168.1.1:8080/
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /.ssh/id_rsa.pub.
Your public key has been saved in /.ssh/id_rsa.pub.pub.
The key fingerprint is:
66:f2:e7:30:d0:b8:7e:b5:0a:a1:54:01:2a:c9:fa:3e root@a2a8a5e8c383
The key's randomart image is:
+--[ RSA 2048]----+
|  ..o.           |
|.o .             |
|+.. .            |
|o+ . .           |
|+ o .   S        |
| +   o .         |
|. + . o          |
|o.++.E           |
| *++.            |
+-----------------+
Please type gitlab-ci runners token: 
7a7154771ce1aadd8b08
You are using an old or stdlib version of json gem
Please upgrade to the recent version by adding this to your Gemfile:

  gem 'json', '~> 1.7.7'

Runner Token: bcfbefbd0c414f6766c23943f11b65
Runner registered. Feel free to start it
```

Once you have a container and setup the SSH key, you need to browse to your Gitlab CI and add that runner to at least one project. Alternatively, you can that runner to all of the projects.

![Click the "Assign to all" button][addtoall]

[addtoall]: https://github.com/Ensequence/dockerfiles/gitlab-ci-runner/raw/master/addtoall.png "Assign to all"


### 2. Ensure SSH Connectivity

Once the install is finished, Docker will close the process.  Now, you need to commit the work done above into a new container.  To find the result of the previous docker command:

```bash
$ docker ps -a | head -n 2
ID                  IMAGE                              COMMAND                CREATED             STATUS              PORTS
50a2e96272af        weisjohn/gitlab-ci-runner:latest   /gcr/bin/install       40 seconds ago      Exit 0
```

The "50a2e96272af" is the ID of the container that was just installed.  To use it, you want to commit it to a named container. You should pick some sort of name like gitlab-ci-runner

```bash
$ docker commit 50a2e96272af gitlab-ci-runner
```

After committing the container to the new repository `gitlab-ci-runner`, you now must add your Gitlab key fingerprint to the list of known hosts.

```bash
root@94041103155a:/# ssh git@192.168.1.1
The authenticity of host '192.168.1.1 (192.168.1.1)' can't be established.
ECDSA key fingerprint is 6c:81:e0:19:e9:72:d0:19:d4:e0:02:ec:6f:5c:8c:9f.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.1.1' (ECDSA) to the list of known hosts.
root@94041103155a:/# exit
```

Now we need to commit again.  This time, let's specify a default command to run upon startup

```bash
$ docker ps -a | head -n 2
ID                  IMAGE                              COMMAND                CREATED             STATUS              PORTS
94041103155a        gitlab-ci-runner:latest            /bin/bash              7 minutes ago       Exit 130
$ docker commit -run="{\"Cmd\": [\"/gcr/bin/runner\"] }" 94041103155a gitlab-ci-runner
```

(Don't worry if that looks confusing. The only thing you need to change is 94041103155a to be whatever your hash was.)


### 3. Check Connectivity

Now, let's make sure we can run the image:

```bash
$ docker run -i -t gitlab-ci-runner
* Gitlab CI Runner started
* Waiting for builds
2013-07-12 20:43:54 +0000 | Checking for builds...nothing
```

Once you see that, you can `SIGINT` (Ctrl + C) to escape. 

Congratulations!  Your image is now ready to run.


### 4. Run as a Daemon

```
$ docker run -d gitlab-ci-runner
0b1bea0ef359
$ docker ps
ID                  IMAGE                     COMMAND             CREATED             STATUS              PORTS
0b1bea0ef359        gitlab-ci-runner:latest   /gcr/bin/runner     4 seconds ago       Up 3 seconds
```

Your daemon is now running in the background.  You can now send it builds. 

