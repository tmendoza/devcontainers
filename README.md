# Introduction
My repository of special purpose desktop development vscode containers

# Description
This repository contains a collection of LXC/LXD containers, purpose built, for software development.  
Since I do development in many different languages , using many diferent tools depending on the language (LISP, Python, Go, Rust, C, C++, Plan9, STM32 embedded, etc), lxc containers are 
a great way for managing language ecosystem tooling and development environments.  

## Reasons for LXC/LXD vs Docker

> application containers run a single app/process, whereas system containers run a full operating system giving them flexibility for the workload types they support.  [LXD vs Docker](https://ubuntu.com/blog/lxd-vs-docker)

LXD manages system containers.  Unlike Docker, which manages Application containers, system containers are more like tradtional virtual machines.  They come with a whole system and also can host several  applications.  As a developer, I don't need just one application.  I need a whole suite of applications and using a system container better fits more working model of development environments.

## Directory Structure
 /manifests - This directory contains the shell scripts for building the LXD system containers.  There will be one shell scripts per development environment type. 

There will be subdirectories, each containing Dockerfiles for specific IDE's.

### /manifests/vscode - VSCode Environments

* Desktop-GUI-PySide6-Python-3.11-noenv-Linux-Ubuntu-ALL.sh 
* Desktop-GUI-SimpleGUI-Python-3.11-noenv-Linux-Ubuntu-ALL.sh 

### /manifests/neovim - Neo Vim Environments

* Desktop-GUI-Machine-Learning-Python-3.11-venv-Linux-Ubuntu-ALL.sh 

## Installation

### Prerequisites
The first step in setting up your Linux laptop.  These instructions assume a version of Ubuntu Desktop has been installed on the machine your are using.  These instructions also assume that you already have a login id configured on this laptop and that you can login successfully to the machine running a recent version of Ubuntu Desktop.  Finally, these directions also assume that you have 'sudo' access on the system we need to modify.  'sudo' access will be needed because you will need to run some installtion and system commands as root to properly perform the installation and configuration of LXC/LXD.

#### Install VS Code on host system
#### Install Git 
#### Setup GitHub 
##### Generate SSH keys 
##### Configure GitHub using new SSH key 
##### Create Test GitHub repository
##### Checkout Test GitHub repository
##### Checkout 'devcontainers' GitHub repository
### Install LXD


