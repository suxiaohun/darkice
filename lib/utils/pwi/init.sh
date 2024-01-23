#!/bin/bash

cp --no-clobber lib/* /usr/lib
cat /init_env/sources.list > /etc/apt/sources.list

dpkg --add-architecture i386
apt update
apt install -y vim openjdk-8-jdk libc6:i386 libncurses5:i386 libstdc++6:i386

