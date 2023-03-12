FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install zlib1g-dev -y
RUN apt-get install libncurses5-dev -y
RUN apt-get install libgdbm-dev -y
RUN apt-get install libnss3-dev -y
RUN apt-get install libssl-dev -y
RUN apt-get install libreadline-dev -y
RUN apt-get install libffi-dev -y
RUN apt-get install ffmpeg -y 
RUN apt-get install libgl1 -y
RUN apt-get install libsm6 -y 
RUN apt-get install libxext6 -y
RUN apt-get install wget -y

# Install the following packages
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install python3.10 -y
RUN apt-get install python3.10-tk -y 

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

RUN apt-get install curl -y
        
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN python3.10 -m pip --version
RUN python3.10 -m pip install --upgrade pip

# Install any Python modules required in the notebook
RUN pip3.10 install pandas
RUN pip3.10 install numpy 
#RUN pip3.10 install pysimplegui
RUN pip3.10 install -U PySide6
RUN mkdir -p /home/devuser

ADD ./python/main-pyside6-test.py /home/devuser/

ENV DISPLAY=host.docker.internal:0.0 

CMD /usr/bin/python /home/devuser/main-pyside6-test.py
