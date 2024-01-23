FROM ubuntu:20.04

ARG JAVA_DIR=/usr/java/jdk1.8.0_261-amd64

RUN mkdir -p /init_env && mkdir -p /usr/java

COPY init_env /init_env/

RUN cat /init_env/sources.list > /etc/apt/sources.list \
    && dpkg --add-architecture i386 && apt update  \
    && apt install -y vim libc6:i386 libncurses5:i386 libstdc++6:i386 \
    && cp -a /init_env/lib_g/* /usr/lib \
    && tar zxvf /init_env/jdk.tar -C /usr/java \
    && rm -rf /init_env

ENV JAVA_HOME=$JAVA_DIR \
    CLASSPATH=.:$JAVA_DIR/lib/tools.jar:$JAVA_DIR/lib/dt.jar \
    PATH=$JAVA_DIR/bin:$PATH

