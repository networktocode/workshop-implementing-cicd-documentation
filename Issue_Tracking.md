# Issue Tracking for Lab

1. Restarting codespace Docker daemon stopped working. 

Status: investigating
Workaround: restart codespace

2. Initial codespace spec not powerful enough to run 4-node containerlab. 

Workaround: launch with bigger spec, can nailed down in devcontainer.json: 

```
// "hostRequirements": {
    //     "cpus": 4,
    //     "memory": "16gb",
    //     "storage": "32gb"
    // },
```

3. Containerlab mgmt network not reachable by Gitlab-runner in custom network. 

Status: investigate if we can use fixed mgmt IP in bridge network. 
Workaround: Use bridge mgmt network for now with dynamic IP for mgmt. 

```
mgmt:
  # network: "network-lab"
  # ipv4-subnet: "172.24.78.0/24"
  network: "bridge"
  # ipv4-subnet: "172.17.0.0/16"
```

4. GitLab runner defaults to system runner

Workaround: Use tags to register runner as well as specify in steps. 

