# Introduction
This project is used to learn ruby and rails, and contains many practical tools.

It can be deployed on bare metal or in containers.

# Features
* Test ruby features
* Test gems
* Test rails features
* Test Docker
* Test k8s
* Useful tools
    - color selector
    - websocket example  
    - free novels to read
    - json content valid
    - search phone number address info
    - yys activities
    - unicode convert
    - file encoding convert
    - zip、unzip commands
    - ffmpeg commands
    - ...

# Debug
```shell
git clone -b master git@github.com:suxiaohun/darkice.git
cd darkice
rails s -b 0.0.0.0
```

# Deploy
1. `make build` will build the docker image.
2. If you want to deploy in a k8s cluster, refer to: https://github.com/suxiaohun/chronos

