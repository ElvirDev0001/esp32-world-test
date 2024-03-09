#!/bin/bash

# Start the Husarnet client
husarnet daemon > /dev/null 2>&1 &

# Wait a bit to ensure Husarnet starts
sleep 5

# Join the Husarnet network
husarnet join ${HUSARNET_JOIN_CODE} ${HUSARNET_HOSTNAME}

# Start the Flask application
exec python main.py