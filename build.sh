#!/bin/bash

docker rmi pwn-env
docker build -t pwn-env .
