# Autocon2 CI/CD Workshop Development Repository

>[!NOTE]
> Use this repository to collaborately devlope content before publishing to user. 

Hello! Welcome to [Autocon2 CI/CD workshop](https://networkautomation.forum/autocon2#workshop) proctored by [Eric Chou](https://github.com/ericchou1/), [Jeff Kala](https://github.com/jeffkala), and assisted by [Tim Fiola](https://github.com/tim-fiola). 

You can find the different lab instructions in each of the folders in this repository. 

- [Lab 1. Basic Git Operations](./Lab_1_Basic_Git_Operations/README.md)
- [Lab 2. First Pipeline](./Lab_2_First_Pipeline/README.md)
- [Lab 3. Build Reviews](./Lab_3_Build_Reviews/README.md)
- [Lab 4. Configuration Generation with Templates](./Lab_4_Configuration_Generation_with_Templates/README.md)
- [Lab 5. ACL Change](./Lab_5_ACL_Change/README.md)
- [Lab 6. Testing Frameworks](./Lab_6_Testing_Frameworks/README.md)

But first things first, we would like to walk you through how to set up the development environment for the workshop.

## Lab Components

Here is an overview of the lab: 

![Lab_Diagram_v1](images/Lab_Diagram_v1.drawio.png)

Here are the components: 

- [GitHub Codespace](https://github.com/features/codespaces): We will use GitHub codepsace as our IDE as well as the place to run our network lab. They offer a generous free tier that should remain to be free for the furation of this lab. 
- [Containerlab](https://containerlab.dev/): We will use containerlab for our lab devices running inside of codepsace. 
- [GitLab for Personal Projects](https://about.gitlab.com/pricing/): We will use the SaaS version of GitLab as we build our CI/CD pipeline. 
- [Arista cEOS](https://containerlab.dev/manual/kinds/ceos/): We will use Arista cEOS for our lab. 

Please do the following: 

1. Register for a free GitLab.com account [here](https://gitlab.com/-/trial_registrations/new?_gl=1%2A1c025i%2A_ga%2AMTYyOTY3MzIyLjE2ODcyNzM0MTI.%2A_ga_ENFH3X7M5Y%2AMTY4NzI3MzQxMS4xLjAuMTY4NzI3MzQxNC4wLjAuMA). 
2. Download the free Arista cEOS image [here](https://www.arista.com/en/login). We will import it into Codespace later. Please download images later than 4.28. We will use 4.30.4M for our lab. 

> [!TIP]
You just need to download the image for now, for reference here is the import instruction from [containerlab](https://www.youtube.com/watch?v=KJMVH2okO24) and a nice walk through video from [Roman](https://www.youtube.com/watch?v=KJMVH2okO24). 

### Lab Setup

Alright, now it is time to tie everything together. 

1. Start Codespace by going to Code -> 'Create codespace on main': 

![codespace_start](images/codespace_start.png)

2. After codespace is started, right click in the Explorer section and choose upload: 

![upload_ceos](images/upload_ceos.png)

3. Use command ```docker import cEOS64.<version>.tar.xz ceos:<version>``` to import the image, for example: 

``docker import cEOS64-lab-4.32.0F.tar.xz ceos:4.32.0F``

4. Register GitLab Runner: 
    - Get runner token via Project -> Settings -> CI/CD -> Project Runners
    - Register runner via the following command: 

```
$ gitlab-runner register  --url https://gitlab.com  --token <token>
... <skip>
Enter a name for the runner. This is stored only in the local config.toml file:
[codespaces-38d00a]: <unique name, example: echou-codespace-test1>
Enter an executor: virtualbox, docker-windows, kubernetes, docker-autoscaler, instance, custom, parallels, docker, docker+machine, shell, ssh:
<shell>
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
 
Configuration (with the authentication token) was saved in "/home/vscode/.gitlab-runner/config.toml"
```

### Video Demonstration

[![video_demo](images/video_demo_screenshot.png)](https://www.youtube.com/watch?v=KJMVH2okO24)








