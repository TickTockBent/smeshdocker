#!/bin/sh

# Here we make sure no config files exist and then curl a networks endpoint and return the first element's conf property and pass that to wget to get the latest config
rm -f config.json
curl -s 'https://discover.spacemesh.io/networks.json' | jq -r '.[0]."conf"' | xargs wget