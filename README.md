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
$ git clone https://github.com/tmendoza/devcontainers.git
`

At this point you should have everything you need to begin the installation of LXD

### Install LXD
Installing LXD is pretty straightforward on an Ubuntu system  To install LXD you will install what is called a Snap.  So what is a snap?  Well a [snap](https://ubuntu.com/core/services/guide/snaps-intro) is just a containerized version of a software application.  See!  Even the Linux distributors are doing what we are attempting to do here.  They are creating packaged environments for specific applications.  

This is a more narrow use-case than LXD containers.  Snap containers are more like Docker containers in that they package up just an application and all of it's dependencies.  It is not a whole system like an LXD container or LXD Virtual machine.  You can think of these different virtualization technologies as existing on a spectrum of virtualization.  To the far left you have small virtual environments and on the far right you have more heavy weight virtual environments

#### Virtual environment types and size

| Small | Medium | Large | X-Large |
| ----- | ------ | ----- | ------- |
| snap  | docker | lxd   | vm      |

#### Install the LXD binaries

`
$ sudo snap install lxd
`

#### Initialize LXD 
Before you can create an LXD instance, you will need to initialize the system.  To do this we run the command 'lxd init'

`
$ sudo lxd init
`

AS part of the initialization process you will be asked a series of questions.  You should accept the deaults for all of the questions with the exception of the "Storage Pools" section.   Here you will want to select 'zfs'

### Manage container instances
Now that LXD is installed, we want to start creating our own custom container images and start them up to do some work.  To do this, the LXD suite of tools comes with a command line tool called 'lxc'.

LXC is a CLI tool for managing the lifecycle of some type of container.  We are not going to cover all of it's capabilities.  We will concern ourselves with '6' main tools:

* lxc launch
* lxc list
* lxc start
* lxc stop 
* lxc exec
* lxc delete 

#### Launching a new container
To launch a new container we use the 'lxc launch' command.  If I wanted to create a new Ubuntu Jammy/22.04 based container and call it "python-3-11-desktop" then I would use the following command with output:


`
$ lxc launch ubuntu:22.04 python-3-11-desktop
`

`
Creating python-3-11-desktop
Starting python-3-11-desktop
`

#### How do I list all of my container instances?
When you create a new container using the 'lxc launch' command, LXD downloads the ubuntu images and stores it and it's configuration in the LXD database.  But how do you view the status of your containers?  Using the 'lxc list' command you can list all of the containers you have built. 

`
$ lxc list -f csv
`

`
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
`

#### How do I stop a running container
First get the name of the container you want to stop

`
$ lxc list -f csv
`

`
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
`

The name is the data in the first column.  The value is 'python-3-11-desktop'.  That is the name we will use going forward.

To stop a running container we use the 'lxc stop' command

`
$ lxc stop python-3-11-desktop
`

Now lets list the container database to check on the status of the container we are trying to manage

`
$ lxc list -f csv
`

`
python-3-11-desktop,STOPPED,,,CONTAINER,0
`

As you can see the container is now stopped.  

#### How do I start an 'lxd' container instance?
Well first lets check on the status of the existing container instances

`
$ lxc list -f csv
`

`
python-3-11-desktop,STOPPED,,,CONTAINER,0
`

We see that it is in the "STOPPED" state.  Lets start it back up

`
$ lxc start python-3-11-desktop
`

Now lets list the contents of the LXD database to see what the status of the containers are

`
$ lxc list -f csv
`

`
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0
`

As you can see the container is now running.

#### How do I delete an 'lxd' container instance?
Deleting a container instance is pretty straightforward.  Just know, that before you can delete a container it must be stopped.  Also, know that deleting a container deletes any and all data associated with that current container.  What this means is that if you do not have a backup of your container nor a backup of the data within you container, deleting the container using 'lxc delete <name>' will delete everything both in and about your container.

First lets see what is currently running

`
$ lxc list -f csv
`

`
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0
`

We see that it is running.  As mentioned above, to delete a container it must first be stopped.  Lets stop this running container


`
$ lxc stop python-3-11-desktop
`

Now that it is stopped, lets delete it from the LXD database


`
$ lxc delete python-3-11-desktop
`

Lets list the container database again, to see the status of available containers

`
$ lxc list -f csv
`

Now you can see that it has been deleted.

#### How do I login to my new container?
Logging into a container is as simple as running a command inside of the container and then have it execute in an interactive mode.  To do this we will use the 'lxc exec' command to execute an interactive 'bashj' shell.  From within this shell you will be 'inside' of the container.  What this means is that now any command you run from within this shell running inside of the container, it will be confined to the container.  

`
$ lxc exec python-3-11-desktop --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
`

You will now be dropped into a shell INSIDE of the container 'python-3-11-desktop'

`
ubuntu@python-3-11-desktop:~$ 
`
As you can see above, by running the 'lxc exec ...' command you know have a shell inside of the container.  In addittion to that, any modifications you make to the filesystem, such as installing software, changing permissions, moving files around, will be entirely contained within this 'lxd' container.

To 'log out' of the container just type 'exit' as you normally woulkd to exit a UNIX shell.

`
ubuntu@python-3-11-desktop:~$ exit
`

`
logout
`

`
tmendoza@godbox-Linux:/media/tmendoza/
`

You should now be back into the original shell where you ran the 'lxc exec ...' command.

### Customizing Container images
Now that you know how to manage the lifecycle of an LXD container instance, we now need to move into customizing the base image.  See, all of the work you just did only built a basic container.  Basic containers are just that:  basic.  They have nothing really in them other than the core basic things you need to run an operating system.  This is nice because your container can be customized to contain only those things that you want inside of it.  

To make modifications to a container you use the 'lxc exec' command.  Why?  Because this is the only command that allows you to directly interact with the container from OUTSIDE of the container.  So I can run 'lxc exec <container name> <some Linux CLI command>' and it will run '<some Linux CLI command>' within the container.  By default, the 'lxc exec' command runs as root, so it can be easily used to install software packages into the container.  

Now to do this normally you can run command either from a shell on the host, or you can also script this so you don't have to type it all over again in case you wanted to rebuild your environment from scratch.  As a matter of fact, the 'manifests' directory of this repository contains folders of shell scripts for building custom LXD Containers.  Here is an example:

```
#!/bin/bash

ENVNAME="ubuntu-22-04-python3-10"

lxc list | grep "$ENVNAME"

if [[ $? -eq 0 ]]
then
    lxc stop $ENVNAME 
    lxc delete $ENVNAME 
fi

lxc launch images:ubuntu/22.04 $ENVNAME

lxc config set $ENVNAME raw.idmap "both $UID 1000"
lxc config device add $ENVNAME X1 disk path=/tmp/.X11-unix/X1 source=/tmp/.X11-unix/X1 
lxc config device add $ENVNAME Xauthority disk path=/home/ubuntu/.Xauthority source=${XAUTHORITY}

lxc restart $ENVNAME

echo "Letting the system settle..."
sleep 10 

lxc exec $ENVNAME --  apt-get update
lxc exec $ENVNAME --  apt-get install build-essential -y
lxc exec $ENVNAME --  apt-get install zlib1g-dev -y
lxc exec $ENVNAME --  apt-get install libncurses5-dev -y
lxc exec $ENVNAME --  apt-get install libgdbm-dev -y
lxc exec $ENVNAME --  apt-get install libnss3-dev -y
lxc exec $ENVNAME --  apt-get install libssl-dev -y
lxc exec $ENVNAME --  apt-get install libreadline-dev -y
lxc exec $ENVNAME --  apt-get install libffi-dev -y
lxc exec $ENVNAME --  apt-get install ffmpeg -y 
lxc exec $ENVNAME --  apt-get install libgl1 -y
lxc exec $ENVNAME --  apt-get install libsm6 -y 
lxc exec $ENVNAME --  apt-get install libxext6 -y
lxc exec $ENVNAME --  apt-get install libegl-dev -y 
lxc exec $ENVNAME --  apt-get install qt6-base-dev -y
lxc exec $ENVNAME --  apt-get install wget -y
```
