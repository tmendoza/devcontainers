## Building a QEMU QCOW Image
```
$ qemu-img.exe create -f qcow2 ubuntu-18.04-disk.qcow 10G
```

## Starting QEMU on Windows
```
$ qemu-system-x86_64.exe -boot d -cdrom .\ubuntu-18.04.6-desktop-amd64.iso -m 4096 -hda .\ubuntu-18.04-disk.qcow
```

