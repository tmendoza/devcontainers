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

LXC is a CLI tool for managing the lifecycle of some type of container.  For example, using the LXC command you can do the following:

`
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
`

We are not going to cover all of these items.  We will concern ourselves with '5' main tools:

* lxc launch
* lxc list
* lxc start
* lxc stop 
* lxc restart
* lxc exec
* lxc file
* lxc delete 

#### Launching a new container
To launch a new container we use the 'lxc launch' command.  The signature of the command is as follows:

`
$ lxc launch --help
Description:
  Create and start instances from images

Usage:
  lxc launch [<remote>:]<image> [<remote>:][<name>] [flags]

Examples:
  lxc launch ubuntu:22.04 u1
`
**image** is the name of a base OS image (Ubuntu, Centos, Debian, etc)
**name** is the name you want to give the container.  This names the container and is used in later commands

If I wanted to create a new Ubuntu Jammy/22.04 based container and call it "python-3-11-desktop" then I would use the following command with output:
`
$ lxc launch ubuntu:22.04 python-3-11-desktop
Creating python-3-11-desktop
Starting python-3-11-desktop
`

#### Where is this 'container' and what is it's status?
When you create a new container using the lxc command, the lxc command downloads the ubuntu images and stores it and it's configuration in the lxd database.  Using the lxc command you can list all of the containers you have built. 

`
$ lxc list
+-------------------------+---------+----------------------+------+-----------+-----------+
|          NAME           |  STATE  |         IPV4         | IPV6 |   TYPE    | SNAPSHOTS |
+-------------------------+---------+----------------------+------+-----------+-----------+
| python-3-11-desktop     | RUNNING | 10.209.29.252 (eth0) |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
| ubuntu-22-04-python3-10 | RUNNING | 10.209.29.96 (eth0)  |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
| ubuntu-22-04-python3-11 | STOPPED |                      |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+

`

As you can see, I have two existing containers within my desktop machines LXD database.  One is running and the other one is stopped.  You can also see the one we just created.  It is running and is accessible.  But before we 'login' to your new container, lets delete the old ones listed above.

#### How do I delete an 'lxd' container instance?
Deleting a container instance is pretty straightforward.  Just know, that before you can delete a container it must be stopped.  Also, know that deleting a container deletes any and all data associated with that current container.  What this means is that if you do not have a backup of your container nor a backup of the data within you container, deleting the container using 'lxc delete <name>' will delete everything both in and about your container.

Let's first delete the container named 'ubuntu-22-04-python3-10'.  Notice that it is running.  We need to stop it first.

#### How do I stop a running container?
Stopping a container is super simple
`
$ lxc stop ubuntu-22-04-python3-10
`

Now do an 'lxc list' to see the current state of the containers
`
$ lxc list
+-------------------------+---------+----------------------+------+-----------+-----------+
|          NAME           |  STATE  |         IPV4         | IPV6 |   TYPE    | SNAPSHOTS |
+-------------------------+---------+----------------------+------+-----------+-----------+
| python-3-11-desktop     | RUNNING | 10.209.29.252 (eth0) |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
| ubuntu-22-04-python3-10 | STOPPED |                      |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
| ubuntu-22-04-python3-11 | STOPPED |                      |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
`

Now that the right container has been stopped, lets go ahead and delete it

`
$ lxc delete ubuntu-22-04-python3-10
`

Lets list the container database again, to see the status of available containers
`
$ lxc list
+-------------------------+---------+----------------------+------+-----------+-----------+
|          NAME           |  STATE  |         IPV4         | IPV6 |   TYPE    | SNAPSHOTS |
+-------------------------+---------+----------------------+------+-----------+-----------+
| python-3-11-desktop     | RUNNING | 10.209.29.252 (eth0) |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
| ubuntu-22-04-python3-11 | STOPPED |                      |      | CONTAINER | 0         |
+-------------------------+---------+----------------------+------+-----------+-----------+
`

Now you can see that it has been deleted.

#### How do I login to my new container?
Logging into a container is as simple as running a command inside of the container and then have it execute in an interactive mode.  To do this we will use the 'lxc exec' command to execute an interactive 'bashj' shell.  From within this shell you will be 'inside' of the container.  What this means is that now any command you run from within this shell running inside of the container, it will be confined to the container.  

`
$ lxc exec python-3-11-desktop --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
ubuntu@python-3-11-desktop:~$ ps auxwww|head -20
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0 167256  9764 ?        Ss   18:17   0:00 /sbin/init
root          57  0.0  0.0  31540 10428 ?        Ss   18:17   0:00 /lib/systemd/systemd-journald
root         103  0.0  0.0  11096  4008 ?        Ss   18:17   0:00 /lib/systemd/systemd-udevd
root         109  0.0  0.0   4852  1476 ?        Ss   18:17   0:00 snapfuse /var/lib/snapd/snaps/core20_1822.snap /snap/core20/1822 -o ro,nodev,allow_other,suid
root         110  0.0  0.0   4716  1476 ?        Ss   18:17   0:01 snapfuse /var/lib/snapd/snaps/snapd_18357.snap /snap/snapd/18357 -o ro,nodev,allow_other,suid
root         111  0.0  0.0   4800  1252 ?        Ss   18:17   0:00 snapfuse /var/lib/snapd/snaps/lxd_24322.snap /snap/lxd/24322 -o ro,nodev,allow_other,suid
systemd+     302  0.0  0.0  16120  5912 ?        Ss   18:17   0:00 /lib/systemd/systemd-networkd
systemd+     304  0.0  0.0  25260  9952 ?        Ss   18:17   0:00 /lib/systemd/systemd-resolved
root         336  0.0  0.0   7284  1724 ?        Ss   18:17   0:00 /usr/sbin/cron -f -P
message+     337  0.0  0.0   8584  3124 ?        Ss   18:17   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         342  0.0  0.0  32984 15776 ?        Ss   18:17   0:00 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
syslog       343  0.0  0.0 152768  3280 ?        Ssl  18:17   0:00 /usr/sbin/rsyslogd -n -iNONE
root         345  0.0  0.1 2795076 43296 ?       Ssl  18:17   0:00 /usr/lib/snapd/snapd
root         347  0.0  0.0  15040  5300 ?        Ss   18:17   0:00 /lib/systemd/systemd-logind
root         356  0.0  0.0   6216   892 pts/0    Ss+  18:17   0:00 /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 linux
root         363  0.0  0.0  15424  5744 ?        Ss   18:17   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root         370  0.0  0.0 235444  5708 ?        Ssl  18:17   0:00 /usr/libexec/polkitd --no-debug
root         371  0.0  0.0 110276 16756 ?        Ssl  18:17   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
ubuntu      1045  0.0  0.0   9092  4248 pts/1    Ss   18:31   0:00 bash --login
`
As you can see above, by running the 'lxc exec ...' command you know have a shell inside of the container.  Once inside of the container, I executed the 'ps auxwww | head -20' command to show you that the 'ps' command is only seeing what is inside of the container.  In addittion to that, any modifications you make to the filesystem, such as installing software, changing permissions, moving files around, will be entirely contained within this 'lxd' container.

To 'log out' of the container just type 'exit' as you normally woulkd to exit a UNIX shell.
`
ubuntu@python-3-11-desktop:~$ exit
logout
tmendoza@godbox-Linux:/media/tmendoza/
`



