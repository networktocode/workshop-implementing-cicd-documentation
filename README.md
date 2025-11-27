# Implementing CICD Workshop Development Repository

Hello! Welcome to Implementing CICD Workshop proctored by [Network to Code](https://github.com/networktocode).

You can find the different lab instructions in each of the folders in this repository. 

- [Lab 1. Basic Git Operations](./Lab_1_Basic_Git_Operations/README.md)
- [Lab 2. First Pipeline](./Lab_2_First_Pipeline/README.md)
- [Lab 3. Collaboration Tools](./Lab_3_Collaboration_Tools/README.md)
- [Lab 4. Source Code Checks](./Lab_4_Source_Code_Checks/README.md)
- [Lab 5. Generate Configs with Templates](./Lab_5_Generate_Configs/README.md)
- [Lab 6. Testing Frameworks](./Lab_6_Testing_Frameworks/README.md)

But first things first, we would like to walk you through how to set up the development environment for the workshop.

## Lab Components

Here is an overview of lab:   

![Lab_Diagram_v1](images/Lab_Diagram_v1.drawio.png)

Here are the details regarding each components: 

- [GitLab](https://about.gitlab.com/pricing/): We will use the SaaS version of GitLab as the CI server. The CI server handles the committing, building, testing, staging, and releasing the changes. 
- [GitLab Runners](https://docs.gitlab.com/runner/): GitLab runners are workers that registers itself with the GitLab server and managed by the GitLab server. They are responsible to carry out the instructions by the GitLab server. 
- [GitHub Codespace](https://github.com/features/codespaces): We will use GitHub codespace as our IDE as well as the virtual server to run our network lab. GitHub provides these container-based development environment for developers. We will use Containerlab to run a few network devices for our lab. GitHub offer a generous free tier in Codespace that should remain to be free for the duration of this lab. 
- [Containerlab](https://containerlab.dev/): We will use containerlab for our lab devices running inside of codespace.  
- [Arista cEOS](https://containerlab.dev/manual/kinds/ceos/): We will use Arista cEOS for our lab for their light overhead and relative high adaption in production networks. 

## GitLab Account Registration and cEOS Download

Please do the following steps to set up the lab: 

1. Register for a free GitLab.com account [here](https://gitlab.com/users/sign_up) if you do not have one. For a new registration, a project name is required, you can use a temp name or 'CICD Workshop Lab1' as that is one of the project we will create later: 

![gitlab_account_signup](images/gitlab_account_signup.png)

2. Download the free Arista cEOS image [here](https://www.arista.com/en/login). The image is free but you do need to register an Arista account with your business email. We will import the Arista image Codespace later. 

![arista_download_1](images/arista_download_1.png)

Please download images later than 4.28. We will use 4.32.0F for our lab. 

![arista_downaload_2](images/arista_download_2.png)

> [!FYI] 
> Download the 64 bit image.

> [!TIP]
You just need to download the image for now, for reference here is the import instruction from [containerlab](https://www.youtube.com/watch?v=KJMVH2okO24) and a nice walk through video from [Roman](https://www.youtube.com/watch?v=KJMVH2okO24). 

### Lab Setup

Alright, now it is time to tie everything together. 

1. In this repository, we can start Codespace by going to Code button on the top left corner and choose 'Create codespace on main': 

![codespace_start](images/codespace_start.png)

> [!TIP] 
> It will take a bit of time to build codespace for the first time, you can click on [building codespace](images/building_codespace.png) to check on the progress. After it started for the first time, when you stop/start the instance it will be much faster. 

Once Codespace is started, we can verify both Docker and containerlab are installed and running: 

```
@ericchou1 ➜ /workspaces/workshop-implementing-cicd (main) $ poetry --version
Poetry (version 1.8.4)

@ericchou1 ➜ /workspaces/workshop-implementing-cicd (main) $ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...<skip>
Hello from Docker!
This message shows that your installation appears to be working correctly.
<skip>

@ericchou1 ➜ /workspaces/workshop-implementing-cicd (main) $ containerlab version
  ____ ___  _   _ _____  _    ___ _   _ _____ ____  _       _     
 / ___/ _ \| \ | |_   _|/ \  |_ _| \ | | ____|  _ \| | __ _| |__  
| |  | | | |  \| | | | / _ \  | ||  \| |  _| | |_) | |/ _` | '_ \ 
| |__| |_| | |\  | | |/ ___ \ | || |\  | |___|  _ <| | (_| | |_) |
 \____\___/|_| \_| |_/_/   \_\___|_| \_|_____|_| \_\_|\__,_|_.__/ 

    version: 0.58.0
     commit: 2c249b2c
       date: 2024-10-15T11:38:50Z
     source: https://github.com/srl-labs/containerlab
 rel. notes: https://containerlab.dev/rn/0.58/
```

2. After codespace is started, right click in the Explorer section and choose upload: 

![upload_ceos](images/upload_ceos.png)


3. Use command ```docker import cEOS64.<version>.tar.xz ceos:<version>``` to import the image, for example: 

```sh
docker import cEOS64-lab-4.32.0F.tar ceos:4.32.0F
```

4. Run the GitLab Runner in a docker container.

```sh
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlab-runner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
```

5. Register GitLab Runner (screenshot following the steps): 
    - Under the GitLab project you created, get runner token via Project -> Settings -> CICD -> Project Runners. 
    - When creating this runner, we will use tags to specify the jobs this runner can pickup. 
    - Copy the `token`.
    - Come back to the Codespace instance.
    - Register runner via the following command `docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register`
    - Answer the questions:
      - Enter GitLab instance: `https://gitlab.com/`
      - Enter the registration token: `<token you copied previously>`
      - Enter name for the runner: `leave the default`
      - Enter an executor: `docker`
      - Enter the default Docker image: `python:3.10`

![gitlabrunner_1](images/gitlabrunner_1.png)

![gitlabrunner_2](images/gitlabrunner_2.png)

Once you populate your `Tags` and go to the next page you will get your registration token.

![gitlabrunner_3](images/gitlabrunner_3.png)

```sh
$ docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register
Runtime platform arch=amd64 os=linux pid=7 revision=c6eae8d7 version=17.5.2

Running in system-mode.

Enter the GitLab instance URL (for example, https://gitlab.com/):
https://gitlab.com/

Enter the registration token:
glrt-t3_ABC123

Verifying runner... is valid runner=t3_GdM4Gs

Enter a name for the runner. This is stored only in the local config.toml file:
[460ba0646748]:

Enter an executor: custom, virtualbox, docker, instance, shell, ssh, parallels, docker-windows, docker+machine, kubernetes, docker-autoscaler:
docker

Enter the default Docker image (for example, ruby:2.7):
python:3.10

Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
```

![gitlabrunner_4](images/gitlabrunner_4.png)
