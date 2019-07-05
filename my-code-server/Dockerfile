# Based on original at https://github.com/cdr/code-server
FROM node:10.15.1

# Install VS Code's deps. These are the only two it seems we need.
RUN apt-get update && apt-get install -y \
	libxkbfile-dev \
	libsecret-1-dev

# In the future, we can use https://github.com/yarnpkg/rfcs/pull/53 to make yarn use the node_modules
# directly which should be fast as it is slow because it populates its own cache every time.
WORKDIR /src
RUN git clone https://github.com/cdr/code-server . && \
	npm install -g yarn@1.13 && \ 
	yarn && \
	NODE_ENV=production yarn task build:server:binary

# We deploy with ubuntu so that devs have a familiar environment.
FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
	openssl \
	net-tools \
	git \
	locales \
	sudo \
	dumb-init \
	vim \
	curl \
	wget \
    nano

RUN locale-gen en_US.UTF-8
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8

# Default to nano 
ENV EDITOR=nano
ENV VISUAL=nano

# Copy server binary and intialize 
COPY --from=0 /src/packages/server/cli-linux-x64 /usr/local/bin/code-server
EXPOSE 8443
ENTRYPOINT ["dumb-init", "code-server"]

# Install Python
RUN sudo apt-get update && sudo apt-get install -y \ 
    python3 \
    python3-pip \
    python \
    python-pip

# Install Golang
RUN sudo apt-get update && sudo apt-get install -y \ 
    golang-go

# Set up non-root-user w/ sudo access
RUN adduser --gecos '' --disabled-password kurtis && \
	echo "kurtis ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER kurtis
