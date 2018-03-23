FROM ubuntu:latest

# specify the node base image with your desired version node:<version>
FROM node:9.5.0

# Set the working directory to /sportit
WORKDIR /sportit

# Copy the current directory contents into the container at /sportit
ADD . /sportit
COPY package.json .
COPY yarn.lock .
COPY start-in-docker.sh .
RUN yarn global add node-gyp

COPY build /sportit/build

# replace this with your application's default port
EXPOSE 7001

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# optionally if you want to run npm global bin without specifying path
ENV PATH=$PATH:/home/node/.npm-global/bin

# Add Tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

# Run your program under Tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN ["chmod", "+x", "start-in-docker.sh"]
CMD ["/sportit/start-in-docker.sh"]



