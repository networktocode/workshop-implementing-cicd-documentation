#!/bin/bash
# install containerlab
curl -sL https://containerlab.dev/setup | sudo -E bash -s "all"
# install gitlab-runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner
