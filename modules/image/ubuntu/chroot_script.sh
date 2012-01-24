#!/bin/bash

groupadd admin
useradd test -g admin
echo -e "test\ntest\n" | passwd test

echo '127.0.0.1 ubuntu.local ubuntu' > /etc/hosts
echo 'ubuntu' > /etc/hostname
hostname ubuntu
