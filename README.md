# Introduction
My repository of special purpose desktop development vscode containers

# Description
This repository contains a collection of tools for building LXD containers, purpose built, for software development. Since I do development in many different languages and on many different platforms (LISP, Python, Go, Rust, C, C++, Plan9, STM32 embedded, etc), containers are a great way for managing a programming language's tooling ecosystem without polluting your base host machine.

## Reasons for LXC/LXD vs Docker

> application containers run a single app/process, whereas system containers run a full operating system giving them flexibility for the workload types they support.  [LXD vs Docker](https://ubuntu.com/blog/lxd-vs-docker)

LXD manages system containers.  Unlike Docker, which manages Application containers, system containers are more like traditional virtual machines.  They come with a whole system and also can host several  applications.  As a developer, I don't need just one application.  I need a whole suite of applications and using a system container better fits more working model of development environments.  I started down the Docker road, but it became too unwieldy and their recent licensing changes make it difficult to depend on them.  LXD seems to fit best when considering my circumstances and personal proclivities.

## Directory Structure

- **/manifests** This directory contains the shell scripts for building the LXD system containers.  There will be one shell scripts per development environment type. 

- **/python** This directory contains some example python scripts that can be copied over to a running container to test whether python is operating as expected.  

There will be subdirectories, each containing Dockerfiles for specific IDE's.

### /manifests/vscode - VSCode Environments

* Desktop-GUI-Python-3.10-VSCode-Linux-Ubuntu-ALL.sh 
* Desktop-GUI-Python-3.11-VSCode-Linux-Ubuntu-ALL.sh 

### /manifests/neovim - Neo Vim Environments

* None yet

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

```bash
sudo apt-get install build-essential
```
#### Install Git 
Next lets install [Git](https://packages.ubuntu.com/jammy/git).  [Git](https://git-scm.com/) is a modern distributed version control system.  It is extremely popular in open-source development communities and has become the defacto standard for managing versioned software.  In our case, we will be using the Git command line tools to interact with the GitHub remote version control & collaboration platform.  Many of the tools you will using during the installation process will come from this repository.  Git is what you will use to access these tools

```bash
sudo apt-get install 
```

##### Checkout 'devcontainers' GitHub repository
Now that you have git installed and have some basic build tools available, we now need to download this repository into your home directory.  If you do not have one already, I would suggest creating a separate directory, under your home directory, that contains all of your GitHub repositories.  

For myself, I always create a directory called 'dev' in my home directory.  Underneath that directory I will have a directory called 'repos'.  It is within this 'repo' directory where I checkout remote GitHub repositories.  Here is an example.

###### First create the 'repos' directory
```bash
mkdir -p $HOME/dev/repos
```

###### Next change directory to this new 'repos' directory
```bash
cd $HOME/dev/repos
```

###### Next checkout the 'devcontainers' repository hosted on GitHub
```bash
git clone https://github.com/tmendoza/devcontainers.git
```

At this point you should have everything you need to begin the installation of LXD

### Install LXD
Installing LXD is pretty straightforward on an Ubuntu system  To install LXD you will install what is called a Snap.  So what is a snap?  Well a [snap](https://ubuntu.com/core/services/guide/snaps-intro) is just a containerized version of a software application.  See!  Even the Linux distributors are doing what we are attempting to do here.  They are creating packaged environments for specific applications.  

This is a more narrow use-case than LXD containers.  Snap containers are more like Docker containers in that they package up just an application and all of it's dependencies.  It is not a whole system like an LXD container or LXD Virtual machine.  You can think of these different virtualization technologies as existing on a spectrum of virtualization.  To the far left you have small virtual environments and on the far right you have more heavy weight virtual environments

#### Virtual environment types and size

| Small | Medium | Large | X-Large |
| ----- | ------ | ----- | ------- |
| snap  | docker | lxd   | vm      |

#### Install the LXD binaries

```bash
sudo snap install lxd
```

#### Initialize LXD 
Before you can create an LXD instance, you will need to initialize the system.  To do this we run the command 'lxd init'

```bash
sudo lxd init
```

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


```bash
lxc launch ubuntu:22.04 python-3-11-desktop
```
```bash
Creating python-3-11-desktop
Starting python-3-11-desktop
```

#### How do I list all of my container instances?
When you create a new container using the 'lxc launch' command, LXD downloads the ubuntu images and stores it and it's configuration in the LXD database.  But how do you view the status of your containers?  Using the 'lxc list' command you can list all of the containers you have built. 

```bash
lxc list -f csv
```
```bash
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
```

#### How do I stop a running container
First get the name of the container you want to stop

```bash
lxc list -f csv
```
```bash
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
```

The name is the data in the first column.  The value is 'python-3-11-desktop'.  That is the name we will use going forward.

To stop a running container we use the 'lxc stop' command

```bash
lxc stop python-3-11-desktop
```

Now lets list the container database to check on the status of the container we are trying to manage

```bash
lxc list -f csv
```
```bash
python-3-11-desktop,STOPPED,,,CONTAINER,0
```

As you can see the container is now stopped.  

#### How do I start an 'lxd' container instance?
Well first lets check on the status of the existing container instances

```bash
lxc list -f csv
```
```
python-3-11-desktop,STOPPED,,,CONTAINER,0
```

We see that it is in the "STOPPED" state.  Lets start it back up

```bash
lxc start python-3-11-desktop
```

Now lets list the contents of the LXD database to see what the status of the containers are

```bash
lxc list -f csv
```
```
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0
```

As you can see the container is now running.

#### How do I delete an 'lxd' container instance?
Deleting a container instance is pretty straightforward.  Just know, that before you can delete a container it must be stopped.  Also, know that deleting a container deletes any and all data associated with that current container.  What this means is that if you do not have a backup of your container nor a backup of the data within you container, deleting the container using 'lxc delete <name>' will delete everything both in and about your container.

First lets see what is currently running

```bash
lxc list -f csv
```
```bash
python-3-11-desktop,RUNNING,10.209.29.252 (eth0),,CONTAINER,0
```

We see that it is running.  As mentioned above, to delete a container it must first be stopped.  Lets stop this running container


```bash
lxc stop python-3-11-desktop
```

Now that it is stopped, lets delete it from the LXD database


```bash
lxc delete python-3-11-desktop
```

Lets list the container database again, to see the status of available containers

```bash
lxc list -f csv
```

Now you can see that it has been deleted.

#### How do I login to my new container?
Logging into a container is as simple as running a command inside of the container and then have it execute in an interactive mode.  To do this we will use the 'lxc exec' command to execute an interactive 'bash' shell.  From within this shell you will be 'inside' of the container.  What this means is that now any command you run from within this shell running inside of the container, it will be confined to the container.  

```bash
lxc exec python-3-11-desktop --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
```

You will now be dropped into a shell INSIDE of the container 'python-3-11-desktop'

```bash
ubuntu@python-3-11-desktop:~$ 
```

As you can see above, by running the 'lxc exec ...' command you know have a shell inside of the container.  In addittion to that, any modifications you make to the filesystem, such as installing software, changing permissions, moving files around, will be entirely contained within this 'lxd' container.

To 'log out' of the container just type 'exit' as you normally woulkd to exit a UNIX shell.

```bash
ubuntu@python-3-11-desktop:~$ exit
logout
tmendoza@godbox-Linux:/media/tmendoza/
```

You should now be back into the original shell where you ran the 'lxc exec ...' command.

### Customizing Container images
Now that you know how to manage the lifecycle of an LXD container instance, we now need to move into customizing the base image.  See, all of the work you just did only built a basic container.  Basic containers are just that:  basic.  They have nothing really in them other than the core basic things you need to run an operating system.  This is nice because your container can be customized to contain only those things that you want inside of it.  

To make modifications to a container you use the 'lxc exec' command.  Why?  Because this is the only command that allows you to directly interact with the container from OUTSIDE of the container.  So I can run 'lxc exec <container name> <some Linux CLI command>' and it will run '<some Linux CLI command>' within the container.  By default, the 'lxc exec' command runs as root, so it can be easily used to install software packages into the container.  

Now to do this normally you can run the command either from a shell on the host, or you can script the process so you don't have to type it all over again in case you wanted to rebuild your environment from scratch.  As a matter of fact, the 'manifests' directory of this repository contains folders of shell scripts for building custom LXD Containers.  Here is an example:

```bash
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

As can be seen from the script above, all it is doing is calling out to 'lxc exec <name>' with the container name and running 'exec' commands to install software packages.  

Basically anything you can do from the command line normally, you can also do using the 'lxc exec ...' command.  Each one of the scripts within the 'manifests' directories looks very similar to this and just executes a bunch of commands that install packages, copy files from the host to the container, delete tmp folders, etc., etc.

To see the full capabilities of the 'lxc' command you can run 

```bash
$ lxc
Description:
  Command line client for LXD

  All of LXD's features can be driven through the various commands below.
  For help with any of those, simply call them with --help.

Usage:
  lxc [command]

Available Commands:
  alias       Manage command aliases
  cluster     Manage cluster members
  config      Manage instance and server configuration options
  console     Attach to instance consoles
  copy        Copy instances within or in between LXD servers
  delete      Delete instances and snapshots
  exec        Execute commands in instances
  export      Export instance backups
  file        Manage files in instances
  help        Help about any command
  image       Manage images
  import      Import instance backups
  info        Show instance or server information
  launch      Create and start instances from images
  list        List instances
  move        Move instances within or in between LXD servers
  network     Manage and attach instances to networks
  operation   List, show and delete background operations
  profile     Manage profiles
  project     Manage projects
  publish     Publish instances as images
  remote      Manage the list of remote servers
  rename      Rename instances and snapshots
  restart     Restart instances
  restore     Restore instances from snapshots
  snapshot    Create instance snapshots
  start       Start instances
  stop        Stop instances
  storage     Manage storage pools and volumes
  version     Show local and remote versions
  warning     Manage warnings

Flags:
      --all            Show less common commands
      --debug          Show all debug messages
      --force-local    Force using the local unix socket
  -h, --help           Print help
      --project        Override the source project
  -q, --quiet          Don't show progress information
      --sub-commands   Use with help or --help to view sub-commands
  -v, --verbose        Show all information messages
      --version        Print version number

Use "lxc [command] --help" for more information about a command.
```

To get the help you need.  

### How do I build a Python 3.11 GUI Development environment using PySimpleGUI and VS Code
Just run the  