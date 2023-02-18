#!/bin/bash

docker rmi -f pwn-env
docker build -t pwn-env .
