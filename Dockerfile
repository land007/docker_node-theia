FROM land007/node:20.3.1

MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

RUN echo $(date "+%Y-%m-%d_%H:%M:%S") >> /.image_times && \
    echo $(date "+%Y-%m-%d_%H:%M:%S") > /.image_time && \
    echo "land007/node-theia" >> /.image_names && \
    echo "land007/node-theia" > /.image_name

RUN apt-get update && apt-get install -y libudev-dev libsecret-1-dev

ADD package.json /theia/
RUN . $HOME/.nvm/nvm.sh && cd /theia && yarn
RUN . $HOME/.nvm/nvm.sh && cd /theia && yarn theia build
RUN echo ". $HOME/.nvm/nvm.sh && cd /theia && yarn start /node --hostname 0.0.0.0 --port 5050 --plugins=local-dir:plugins" >> /task.sh

EXPOSE 5050/tcp

#docker build -t land007/node-theia:latest .
#> docker buildx build --platform linux/amd64,linux/arm64/v8,linux/arm/v7 -t land007/node-theia:latest --push .