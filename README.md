## What is it?

This is a linux docker container I threw together quickly in order to run a spacemesh node. It's quick and dirty and works at the time of writing this. I make no promises it will continue to work, and I do not offer any support for it if it doesn't work. Use at your own risk.

## How do I use it?`

Clone the repo to your local machine and build the docker container. 
Example: `docker build . -t yourcooltagname`

Then run the container, ensure you expose ports 7513 and 9092. 
Example: `docker run -p 7513:7513/tcp -p 9092:9092/tcp`

**NOTE**: I have my own info in the entrypoint run command, so by default this container will send rewards to my own wallet. If you want to overwrite them you should do so as you see fit.

## What the heck is Spacemesh?

Spacemesh is a Proof of Space-Time crypto project. Read more here: https://spacemesh.io/