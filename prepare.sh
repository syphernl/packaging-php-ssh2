#!/bin/bash
mkdir /src
mkdir /dist
mkdir packages

apt-get update && apt-get install libssh2-1-dev -y

cd /src
echo "[Prepare] Path: ${PWD}"

rm ssh2* -rf
wget https://pecl.php.net/get/ssh2 && tar xfvz ssh2
