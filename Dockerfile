FROM jupyter/scipy-notebook

USER $NB_UID
RUN mkdir /home/$NB_USER/tmp

# Install JDK >= 9
user root

ENV JAVA_HOME=/usr
RUN apt-get update
RUN apt-get install -y --no-install-recommends openjdk-11-jdk-headless
RUN apt-get clean

# Download and extract IJava kernel from SpencerPark

RUN cd /tmp && \
    wget https://github.com/SpencerPark/IJava/releases/download/v1.1.2/ijava-1.1.2.zip && \
    unzip ijava-1.1.2.zip && \
    python install.py --sys-prefix
    
USER $NB_UID

# Remove unused folders
RUN rm -r /home/$NB_USER/tmp
RUN rm -r /home/$NB_USER/work

ADD --chown=1000:100 getstarted.ipynb /home/$NB_USER/
