# Start with provided code-server image 
FROM codercom/code-server:v2
USER root

#  # Default to nano
ENV EDITOR=nano
ENV VISUAL=nano
RUN sudo apt-get update && sudo apt-get install -y \ 
    nano \
  && rm -rf /var/lib/apt/lists/*

# Install Python
RUN sudo apt-get update && sudo apt-get install -y \ 
    python3 \
    python3-pip \
    python \
    python-pip \
  && rm -rf /var/lib/apt/lists/*

# Install Golang
RUN sudo apt-get update && sudo apt-get install -y \ 
    golang-go \
  && rm -rf /var/lib/apt/lists/*

# Add personal user
ARG user=kurtis
RUN adduser --gecos '' --disabled-password "${user}" && \
	echo "${user} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER "${user}"