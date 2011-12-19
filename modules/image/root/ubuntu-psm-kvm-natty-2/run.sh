#!/bin/sh

exec kvm -m 1024 -smp 1 -drive file=tmpv0KHdE.qcow2 "$@"
