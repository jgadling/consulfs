#!/bin/bash -e
args=""
if [ ! -z "$CONSUL_TOKEN" ]; then
  args="$args -token $CONSUL_TOKEN"
fi
if [ -z "$MOUNT_DIR" ]; then
  MOUNT_DIR="/consulfs"
fi
mkdir -p $MOUNT_DIR

if [ -z "$CONSUL_ADDR" ]; then
  CONSUL_ADDR="127.0.0.1:8500"
fi

if [ ! -z "$DETACH" ]; then
  consulfs $args $CONSUL_ADDR $MOUNT_DIR &
  exec $@
else
  consulfs $args $CONSUL_ADDR $MOUNT_DIR
fi



