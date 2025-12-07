#!/bin/bash
# install poetry
# curl -sSL https://install.python-poetry.org | python3 -
# install containerlab
bash -c "$(curl -sL https://get.containerlab.dev)"
# install tools
# sudo apt install -y iputils-ping net-tools openssh-client python3-pip python3-venv containerd
# install gitlab-runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install -y gitlab-runner
# Download GitLab Runner Docker image
# docker pull gitlab/gitlab-runner:latest
docker pull registry.gitlab.com/jeffkala/workshop-implementing-cicd-pipelines:latest
docker pull ghcr.io/astral-sh/uv:0.5-python3.11-bookworm-slim
