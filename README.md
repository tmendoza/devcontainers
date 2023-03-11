# devcontainers
My repository of special purpose desktop development vscode containers

# Introduction
This repository contains a collection of Docker containers, purpose built, for software development.  
Since I do development in many different languages on many dofferent platforms, docker containers are 
a great way for managing development environments.  

If you have done development for any significant period of time you have used several different languages, 
on several different platforms.  All using different libraries, and different versions of libraries; different 
compiler suites; different IDE's, etc. your development machine becomes an unmanageable garbage can of 
cruft.  You end up with ".bash_profiles" from hell.  Things like "virtual environments" to manage dependencies, etc.

To fix this the community has started building purpose built development environments which are easy to 
build, easy to modify and easy to maintain over long periods of time. 

# Directory Structure
 /manifests - This directory contains the manifests (Dockerfiles) for building the docker containers.  There will be 
 one manifest per development environment type. 

There will be subdirectories, each containing Dockerfiles for specific IDE's.

## VSCode

* Machine-Learning-PyTorch-Python-3.11-noenv-Linux-Alpine-SMALL.dockerfile 
* Machine-Learning-TensorFlow-Python-3.11-noenv-Linux-Alpine-BIG.dockerfile 
* Desktop-GUI-PyQT5-Python-3.11-venv-Linux-Void-ALL.dockerfile 


