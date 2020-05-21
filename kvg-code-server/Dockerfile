# Start with provided code-server image 
FROM codercom/code-server:latest
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

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh

# Personalize 
ARG user=kurtis
RUN sudo usermod -l "${user}" -d "/home/${user}" coder \
  && sudo usermod -aG docker "${user}" \
  && sudo groupmod --new-name "${user}" coder \
  && sudo sed -i "s/coder/${user}/g" /etc/sudoers.d/nopasswd
USER "${user}"
