# Introduction
LXD/LXC FAQ

# Description
Frequenty asked questions for managing LXD containers using the LXC command

# Table of Contents

[Managing Source Code](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#managing-source-code)
  - [How do I checkout 'devcontainers' (this one) GitHub repository?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-checkout-devcontainers-this-one-github-repository)
    - [First create the 'repos' directory](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#first-create-the-repos-directory)
    - [Next change directory to this new 'repos' directory](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#next-change-directory-to-this-new-repos-directory)
    - [Next checkout the 'devcontainers' repository hosted on GitHub](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#next-checkout-the-devcontainers-repository-hosted-on-github)

[Manage container instances](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#manage-container-instances)
  - [How do I launch a container?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-launch-a-container)
  - [How do I list all of my container instances?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-list-all-of-my-container-instances)
  - [How do I stop a running container?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-stop-a-running-container)
  - [How do I start an 'lxd' container instance?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-start-an-lxd-container-instance)
  - [How do I delete an 'lxd' container instance?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-delete-an-lxd-container-instance)
  - [How do I login to my new container?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-login-to-my-new-container)

[Customizing Container instances](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#customizing-container-images)
  - [How do I build a Python 3.11 GUI Development environment with PySide 6, PySimpleGUI and VS Code](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-build-a-python-311-gui-development-environment-with-pyside-6-pysimplegui-and-vs-code)
  - [How do you launch Visual Studio Code from inside a container?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-you-launch-visual-studio-code-from-inside-a-container)
  - [How do I install Google Chrome within a container?](https://github.com/tmendoza/devcontainers/blob/main/FAQ.md#how-do-i-install-google-chrome-within-a-container)

# Managing Source Code
## How do I checkout 'devcontainers' (this one) GitHub repository?
Now that you have git installed and have some basic build tools available, we now need to download this repository into your home directory.  If you do not have one already, I would suggest creating a separate directory, under your home directory, that contains all of your GitHub repositories.  

For myself, I always create a directory called 'dev' in my home directory.  Underneath that directory I will have a directory called 'repos'.  It is within this 'repos' directory where I checkout remote GitHub repositories.  Here is an example.

### First create the 'repos' directory
```bash
mkdir -p $HOME/dev/repos
```

### Next change directory to this new 'repos' directory
```bash
cd $HOME/dev/repos
```

### Next checkout the 'devcontainers' repository hosted on GitHub
```bash
git clone https://github.com/tmendoza/devcontainers.git
```

# Manage container instances
Now that LXD is installed, we want to start creating our own custom container images and start them up to do some work.  To do this, the LXD suite of tools comes with a command line tool called 'lxc'.

LXC is a CLI tool for managing the lifecycle of some type of container.  We are not going to cover all of it's capabilities.  We will concern ourselves with '6' main tools:

* lxc launch
* lxc list
* lxc start
* lxc stop 
* lxc exec
* lxc delete 

## How do I launch a container?
To launch a new container we use the 'lxc launch' command.  If I wanted to create a new Ubuntu Jammy/22.04 based container and call it "ubuntu-22-04-python3-11" then I would use the following command with output:


```bash
lxc launch ubuntu:22.04 ubuntu-22-04-python3-11
```
```bash
Creating ubuntu-22-04-python3-11
Starting ubuntu-22-04-python3-11
```

## How do I list all of my container instances?
When you create a new container using the 'lxc launch' command, LXD downloads the ubuntu images and stores it and it's configuration in the LXD database.  But how do you view the status of your containers?  Using the 'lxc list' command you can list all of the containers you have built. 

```bash
lxc list -f csv
```
```bash
ubuntu-22-04-python3-11,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
```

## How do I stop a running container?
First get the name of the container you want to stop

```bash
lxc list -f csv
```
```bash
ubuntu-22-04-python3-11,RUNNING,10.209.29.252 (eth0),,CONTAINER,0 
```

The name is the data in the first column.  The value is 'ubuntu-22-04-python3-11'.  That is the name we will use going forward.

To stop a running container we use the 'lxc stop' command

```bash
lxc stop ubuntu-22-04-python3-11
```

Now lets list the container database to check on the status of the container we are trying to manage

```bash
lxc list -f csv
```
```bash
ubuntu-22-04-python3-11,STOPPED,,,CONTAINER,0
```

As you can see the container is now stopped.  

## How do I start an 'lxd' container instance?
Well first lets check on the status of the existing container instances

```bash
lxc list -f csv
```
```
ubuntu-22-04-python3-11,STOPPED,,,CONTAINER,0
```

We see that it is in the "STOPPED" state.  Lets start it back up

```bash
lxc start ubuntu-22-04-python3-11
```

Now lets list the contents of the LXD database to see what the status of the containers are

```bash
lxc list -f csv
```
```
ubuntu-22-04-python3-11,RUNNING,10.209.29.252 (eth0),,CONTAINER,0
```

As you can see the container is now running.

## How do I delete an 'lxd' container instance?
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
lxc stop ubuntu-22-04-python3-11
```

Now that it is stopped, lets delete it from the LXD database


```bash
lxc delete ubuntu-22-04-python3-11
```

Lets list the container database again, to see the status of available containers

```bash
lxc list -f csv
```

Now you can see that it has been deleted.

## How do I login to my new container?
Logging into a container is as simple as running a command inside of the container and then have it execute in an interactive mode.  To do this we will use the 'lxc exec' command to execute an interactive 'bash' shell.  From within this shell you will be 'inside' of the container.  What this means is that now any command you run from within this shell running inside of the container, it will be confined to the container.  

```bash
lxc exec ubuntu-22-04-python3-11 --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
```

You will now be dropped into a shell INSIDE of the container 'ubuntu-22-04-python3-11'

```bash
ubuntu@ubuntu-22-04-python3-11:~$ 
```

As you can see above, by running the 'lxc exec ...' command you know have a shell inside of the container.  In addittion to that, any modifications you make to the filesystem, such as installing software, changing permissions, moving files around, will be entirely contained within this 'lxd' container.

To 'log out' of the container just type 'exit' as you normally woulkd to exit a UNIX shell.

```bash
ubuntu@ubuntu-22-04-python3-11:~$ exit
logout
tmendoza@godbox-Linux:/media/tmendoza/
```

You should now be back into the original shell where you ran the 'lxc exec ...' command.

# Customizing Container images
Now that you know how to manage the lifecycle of an LXD container instance, we now need to move into customizing the base image.  See, all of the work you just did only built a basic container.  Basic containers are just that:  basic.  They have nothing really in them other than the core basic things you need to run an operating system.  This is nice because your container can be customized to contain only those things that you want inside of it.  

To make modifications to a container you use the 'lxc exec' command.  Why?  Because this is the only command that allows you to directly interact with the container from OUTSIDE of the container.  So I can run 'lxc exec <container name> <some Linux CLI command>' and it will run '<some Linux CLI command>' within the container.  By default, the 'lxc exec' command runs as root, so it can be easily used to install software packages into the container.  

Now to do this normally you can run the command either from a shell on the host, or you can script the process so you don't have to type it all over again in case you wanted to rebuild your environment from scratch.  As a matter of fact, the 'manifests' directory of this repository contains folders of shell scripts for building custom LXD Containers.  Here is an example:

```bash
#!/bin/bash

ENVNAME="ubuntu-22-04-python3-11"

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

## How do I build a Python 3.11 GUI Development environment with PySide 6, PySimpleGUI and VS Code
After ensuring LXD is installed, you should be able to execute the various scripts in the **/manifest** directories within this repository.  In this specific use-case we are trying to construct a container instance designed for doing Python GUI development using PySimpleGUI or PySide 6.  In this scenario, we also require Python version 3.11 and also require Visual Studio code be installed as the editor.

Note, that when completed, everything will be running within the container.  This includes Visual Studio Code.  It will look like a normal shell environment where you can launch a GUI for the CLI, but just remember that this is running within the LXD container.

To build a LXD container that fits these requirements run the following command from the root of the 'devcontainers' repository copy on your host machine

```bash
./manifests/vscode/Desktop-GUI-Python-3.11-VSCode-Linux-Ubuntu-ALL.sh

# LOTS OF STUFF HERE
Fetched 5412 kB in 1s (10.3 MB/s)                                    
Selecting previously unselected package libsecret-common.
(Reading database ... 54152 files and directories currently installed.)
Preparing to unpack .../libsecret-common_0.20.5-2_all.deb ...
Unpacking libsecret-common (0.20.5-2) ...
Selecting previously unselected package libsecret-1-0:amd64.
Preparing to unpack .../libsecret-1-0_0.20.5-2_amd64.deb ...
Unpacking libsecret-1-0:amd64 (0.20.5-2) ...
Selecting previously unselected package code.
Preparing to unpack /tmp/code.deb ...
Unpacking code (1.76.2-1678817801) ...
Selecting previously unselected package libvulkan1:amd64.
Preparing to unpack .../libvulkan1_1.3.204.1-2_amd64.deb ...
Unpacking libvulkan1:amd64 (1.3.204.1-2) ...
Selecting previously unselected package mesa-vulkan-drivers:amd64.
Preparing to unpack .../mesa-vulkan-drivers_22.2.5-0ubuntu0.1~22.04.1_amd64.deb ...
Unpacking mesa-vulkan-drivers:amd64 (22.2.5-0ubuntu0.1~22.04.1) ...
Setting up libvulkan1:amd64 (1.3.204.1-2) ...
Setting up libsecret-common (0.20.5-2) ...
Setting up mesa-vulkan-drivers:amd64 (22.2.5-0ubuntu0.1~22.04.1) ...
Setting up libsecret-1-0:amd64 (0.20.5-2) ...
Setting up code (1.76.2-1678817801) ...
Processing triggers for shared-mime-info (2.1-2) ...
Processing triggers for mailcap (3.70+nmu1ubuntu1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.1) ...
ubuntu@ubuntu-22-04-python3-11:~$ 
```

You will get  a lot of output and it may go on for a few minutes so relax.  This is to be expected.  Now what you are seeing at the end

```bash
ubuntu@ubuntu-22-04-python3-11:~$ 
```

Is a shell prompt INSIDE of the container.  You are logged in as the 'ubuntu' user in the container named 'ubuntu-22-04-python3-11'.  That name is defined inside of the script used to build the container image.

If you type 'exit' you will be dropped into a different prompt which represents the host machine.  On my machine when I type 'exit' from within the container my prompt changes as follows

```bash
ubuntu@ubuntu-22-04-python3-11:~$ exit
logout
tmendoza@Godbox-Linux:~/dev/repos/devcontainers$ 
```

My host machine is named 'Godbox-Linux'.  As you can see when I type 'exit' from within the container, it 'logged' me out and dropped me back into the host machine's shell.

To log back into the container first lets find the containers running

```bash
lxc list -f csv
```

```bash
ubuntu-22-04-python3-11,RUNNING,10.209.29.238 (eth0),,CONTAINER,0
```
Now lets log back into the container we just built

```bash
lxc exec ubuntu-22-04-python3-11 --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
```

```bash
ubuntu@ubuntu-22-04-python3-11:~$ 
```

## How do you launch Visual Studio Code from inside a container?
First lets login to your running container

```bash
lxc exec ubuntu-22-04-python3-11 --env DISPLAY=:1 --env HOME=/home/ubuntu --user 1000 -- bash --login
```

```bash
ubuntu@ubuntu-22-04-python3-11:~$ 
```

Now execute the Visual Studio code command line

```bash
code .
```

This will launch Visual Studio code inside of the container.  As you browse around the filesystem from within Visual Studio code, you will notice that you cannot see any files or filesystems on the host system.  This is because you are inside of the container's environment.  This new environment is completely isolated from the host machine.  

Your are free to does as you wish within the containerized environment.  You can install software, remove software, make system modifications, copy files back and forth between the host system and container.  You can ssh out of this environment, assuming you installed SSH ;-)

Anyway, this system is now free to use as you please.

## How do I install Google Chrome within a container?
This installation process avoids the issues associated within using Snap to install things into a container.

Make sure these commands are run from *outside* of the container.  In other words, run these commands from the *host* system (laptop/desktop) not from within a 'guest' system (container).

From within the 'host' system launch a command line terminal.  From the terminal you will run various commands.

First we need to download and install the Google Chrome installer package into the container.  We use the 'curl' command to download the '*.deb' file installer package.  We then save this in the temp directory. 
```bash
lxc exec ubuntu-22-04-python3-11 -- curl -o /tmp/google-installer.deb -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

Next we use the 'apt' command to install the downloaded Google Chrome package residing in /tmp
```bash
lxc exec ubuntu-22-04-python3-11 -- apt install /tmp/google-installer.deb -y
```

Lets do some cleanup and remove the '*.deb' installer.
```bash
lxc exec ubuntu-22-04-python3-11 -- rm -f /tmp/google-installer.deb
```

Lets create a symbolic link that will be easier to use.  Instead of typing out 'google-chrome-stable' you can just type 'chrome' from the command line.
```bash
lxc exec ubuntu-22-04-python3-11 -- ln -s /usr/bin/google-chrome-stable /usr/bin/chrome
```

Now, from *within* the container, start chrome.  It will ask you a few questions the first time it starts up.  One of the questions is regarding setting Chrome as your 'default' browser.  Please select the checkbox so that Chrome is set as your 'default' browser.  This way, any links that are clicked on within a terminal will (hopefully) launch chrome by default.

```bash
chrome
```

Chrome should now function as expected.  Remember, this Chrome is running *inside* of the container.  Any and all cookies managed by Chrome will be inside of the container.  Anything Chrome downloads will be stored within the container.  