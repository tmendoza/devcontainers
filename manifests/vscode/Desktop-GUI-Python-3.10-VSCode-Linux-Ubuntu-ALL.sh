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
lxc config device add $ENVNAME X0 disk path=/tmp/.X11-unix/X0 source=/tmp/.X11-unix/X0 
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

# Install the following packages
lxc exec $ENVNAME --  apt-get update
lxc exec $ENVNAME --  apt-get install software-properties-common -y
lxc exec $ENVNAME --  add-apt-repository ppa:deadsnakes/ppa -y
lxc exec $ENVNAME --  apt-get update
lxc exec $ENVNAME --  apt-get install python3.10 -y
lxc exec $ENVNAME --  apt-get install python3.10-tk -y 

lxc exec $ENVNAME --  update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

lxc exec $ENVNAME -- apt-get install curl -y
lxc exec $ENVNAME -- apt-get install wget -y

lxc exec $ENVNAME -- curl -o /tmp/get-pip.py -sS https://bootstrap.pypa.io/get-pip.py
lxc exec $ENVNAME -- python /tmp/get-pip.py

lxc exec $ENVNAME --  python -m pip --version
lxc exec $ENVNAME --  python -m pip install --upgrade pip

# Install any Python modules required in the notebook
lxc exec $ENVNAME --  pip install pandas
lxc exec $ENVNAME --  pip install numpy 
lxc exec $ENVNAME --  pip uninstall opencv-python
lxc exec $ENVNAME --  pip install opencv-python-headless
lxc exec $ENVNAME --  pip install pysimplegui
lxc exec $ENVNAME --  pip install streamlit
lxc exec $ENVNAME --  pip install -U PySide6

lxc exec $ENVNAME -- apt install x11-apps -y
lxc exec $ENVNAME -- apt install mesa-utils -y
lxc exec $ENVNAME -- apt install alsa-utils -y
lxc exec $ENVNAME -- apt-get install xdg-utils -y

lxc exec $ENVNAME -- apt-get install xauth -y 
lxc exec $ENVNAME -- apt-get install ssh -y
lxc exec $ENVNAME -- apt-get install libxss1 -y
lxc exec $ENVNAME -- apt-get install libxshmfence1 -y 
lxc exec $ENVNAME -- apt-get install libxext-dev -y
lxc exec $ENVNAME -- apt-get install libxrender-dev -y
lxc exec $ENVNAME -- apt-get install libxslt1.1 -y
lxc exec $ENVNAME -- apt-get install libgconf-2-4 -y
lxc exec $ENVNAME -- apt-get install libnotify4 -y
lxc exec $ENVNAME -- apt-get install libnspr4 -y
lxc exec $ENVNAME -- apt-get install libnss3 -y
lxc exec $ENVNAME -- apt-get install libnss3-dev -y 
lxc exec $ENVNAME -- apt-get install libnss3-tools -y
lxc exec $ENVNAME -- apt-get install libxtst-dev -y
lxc exec $ENVNAME -- apt-get install libgtk2.0-0 -y
lxc exec $ENVNAME -- apt-get install libcanberra-gtk-module -y 
lxc exec $ENVNAME -- apt-get install software-properties-common -y 
lxc exec $ENVNAME -- apt-get install gnupg2 -y
lxc exec $ENVNAME -- apt-get install git -y 
lxc exec $ENVNAME -- apt-get install mupdf -y 

lxc exec $ENVNAME -- curl -o /tmp/code.deb -L https://go.microsoft.com/fwlink/?LinkID=760868
lxc exec $ENVNAME -- apt install /tmp/code.deb -y
lxc exec $ENVNAME -- rm -f /tmp/code.deb

lxc file push ./python/main-pysimplegui-test.py $ENVNAME/home/ubuntu/
lxc file push ./python/main-pyside6-test.py $ENVNAME/home/ubuntu/

lxc exec $ENVNAME --env DISPLAY=:0 --env HOME=/home/ubuntu --user 1000 -- bash --login
