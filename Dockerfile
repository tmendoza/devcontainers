FROM ubuntu:18.04 

RUN apt-get update && apt-get install build-essential -y &&\
    apt-get install zlib1g-dev -y && apt-get install libncurses5-dev -y &&\
    apt-get install libgdbm-dev =y && apt-get install libnss3-dev -y &&\
    apt-get install libssl-dev -y && apt-get install libreadline-dev -y &&\
    apt-get install libffi-dev -y && apt-get install wget -y

# Install the following packages
RUN     apt-get update && apt-get install software-properties-common -y &&\
        add-apt-repository ppa:deadsnakes/ppa && apt-get update &&\
        apt-get install python3.11 -y && apt install python3-pip -y &&\
        pip3 install --upgrade pip 
        
# Install any Python modules required in the notebook
RUN     pip3 install pandas && pip3 install numpy && pip3 install seaborn &&\
        pip3 install matplotlib && pip3 install sklearn &&\
        pip3 install python-dotenv &&\
        pip3 install pyspark && \
        pip3 install tqdm && \
        pip3 install pathlib && \
        pip3 install matplotlib && \
        pip3 install utils && \ 
        pip3 install pysimplegui
