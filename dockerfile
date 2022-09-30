FROM ubuntu AS build_base

USER root

# Do updates
RUN apt update && apt -y upgrade

WORKDIR /spacemesh

# Install some dependencies
RUN apt install -y openssl wget unzip curl jq && apt autoremove

# TODO: Ingest branch name from docker-compose.yml file
# ARG BRANCH_NAME

# Fetch the config file
ADD ./get_config.sh /spacemesh/get_config.sh
RUN sh /spacemesh/get_config.sh && rm /spacemesh/get_config.sh

# Download the precompiled binary package from git instead of compiling our own - set it as executible
ADD https://storage.googleapis.com/go-spacemesh-release-builds/v0.2.17-beta.0/Linux.zip /spacemesh/Linux.zip
RUN unzip -j "Linux.zip" "Linux/libgpu-setup.so" && unzip -j "Linux.zip" "Linux/go-spacemesh" && rm Linux.zip
RUN chmod +x go-spacemesh

# Now we make the final node, discarding all of the other stuff we installed during setup
FROM ubuntu AS node

USER root
WORKDIR /spacemesh

# Copy over the files and config
COPY --from=build_base /spacemesh/* ./

# Start the node
# TODO: Decouple the node data so it persists? Need to figure out where the node identity and POST data lives to test this.
# Note: This will run but you need to expose port 7513 and 9092. Example run command: `docker run -p 7513:7513/tcp -p 9092:9092/tcp`
ENTRYPOINT [ "/bin/bash", "-c", "/spacemesh/go-spacemesh --config /spacemesh/config.json -d /spacemesh/smeshdata" ]