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

In the following sections I will be referring to two distinct types of systems:

* Host System
* Guest System

In the Linux virtualization space, which includes things like containers and virtual machines, there is a distinction made between types of systems.  "Host" systems actually host the execution of virtual environments like "containers" and/or "virtual machines".  In our scenario, our Ubuntu Linux Desktop machine, will be the host for the virtual environments we will be creating and running.

Now hosting and managing Linux virtual environments is not the easiest of tasks.  Sure you could do it manually by calling a bunch of low-level system API's or accessing files in the /dev and /proc filesystems, but why do that when you can just run [LXD](https://linuxcontainers.org/lxd/introduction/).

LXD was designed specifically with this task in mind:  make managing low-level containers and virtual machines easy and more efficient.

Now LXD is still considered somewhat lower level than tools like Docker, but this lower level of access provides us with some operational advantages.  We get way more control over how the containers and virtual machines are built.

#### Install essential developers tools on the Host system
To properly use and install LXD and LXC you will need to install a base set of tools on the Ubuntu system.  This core set of tools is called [build-essential](https://packages.ubuntu.com/jammy/devel/build-essential).  This just contains a bunch of core system utilities needed to do any meaningful software development on a Linux system.

`
$ sudo apt-get install build-essential
`
#### Install Git 
Next lets install [Git](https://packages.ubuntu.com/jammy/git).  [Git](https://git-scm.com/) is a modern distributed version control system.  It is extremely popular in open-source development communities and has become the defacto standard for managing versioned software.  In our case, we will be using the Git command line tools to interact with the GitHub remote version control & collaboration platform.  Many of the tools you will using during the installation process will come from this repository.  Git is what you will use to access these tools

`
$ sudo apt-get install 
`

##### Checkout 'devcontainers' GitHub repository
Now that you have git installed and have some basic build tools available, we now need to download this repository into your home directory.  If you do not have one already, I would suggest creating a separate directory, under your home directory, that contains all of your GitHub repositories.  

For myself, I always create a directory called 'dev' in my home directory.  Underneath that directory I will have a directory called 'repos'.  It is within this 'repo' directory where I checkout remote GitHub repositories.  Here is an example.

###### First create the 'repos' directory
`
$ mkdir -p $HOME/dev/repos
`

###### Next change directory to this new 'repos' directory
`
$ cd $HOME/dev/repos
`

###### Next checkout the 'devcontainers' repository hosted on GitHub
`
git clone https://github.com/tmendoza/devcontainers.git
`


### Install LXD


