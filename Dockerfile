FROM ubuntu:16.04
ENV PYTHONUNBUFFERED 1
RUN apt-get -y update && \
    apt-get -y install wget && \
    apt-get -y install git && \
    apt-get -y install python && \
    apt-get -y install python-pip python-dev build-essential 

RUN pip install --upgrade pip && \ 
    pip install --upgrade virtualenv 

RUN apt-get -y install openjdk-8-jre

RUN cd /opt && \
    mkdir opennlp && \
    wget http://mirror.metrocast.net/apache/opennlp/opennlp-1.5.3/apache-opennlp-1.5.3-bin.tar.gz && \
    tar -zxvf apache-opennlp-1.5.3-bin.tar.gz && \
    cd apache-opennlp-1.5.3 && \
    mkdir models && \
    wget http://opennlp.sourceforge.net/models-1.5/en-parser-chunking.bin && \
    mv en-parser-chunking.bin models/

RUN cd /opt && \
    git clone https://github.com/curzona/opennlp-python.git && \
    cd opennlp-python && \
    pip install -r requirements.txt

COPY run-opennlp.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/run-opennlp.sh

ENTRYPOINT ["run-opennlp.sh"]
EXPOSE 8080
