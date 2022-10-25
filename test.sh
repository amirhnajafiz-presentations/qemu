#!/bin/bash

qemu-system-x86_64 -display none -no-user-config -m 2048 \
    -nodefaults -monitor stdio -machine pc,accel=kvm,usb=off \
    -smp 1,maxcpus=2 -cpu IvyBridge-IBRS \
    -qmp unix:/tmp/qmp-sock,server=on,wait=off