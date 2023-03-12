## Building a QEMU QCOW Image
```
$ qemu-img.exe create -f qcow2 ubuntu-18.04-disk.qcow 10G
```

## Starting QEMU on Windows
```
$ qemu-system-x86_64.exe -boot d -cdrom .\ubuntu-18.04.6-desktop-amd64.iso -m 4096 -hda .\ubuntu-18.04-disk.qcow
```

## Prepping Windows for Containers

https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce

## Building a docker container
```
docker build -t ubuntu-python3.11 -f .\Dockerfile .
```

## Running a GUI app inside of a Docker container 

https://medium.com/geekculture/run-a-gui-software-inside-a-docker-container-dce61771f9
https://www.youtube.com/watch?v=BDilFZ9C9mw

## Displaying GUI's on Windows 10 requires an X11 server

https://sourceforge.net/projects/vcxsrv/


