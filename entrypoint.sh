#!/bin/bash

echo "Starting Husarnet setup..."

# Start the Husarnet client without redirecting output to /dev/null to see more details
echo "Starting Husarnet daemon..."
husarnet daemon &
sleep 5  # Give the daemon time to start

# Display Husarnet version for debugging purposes
echo "Husarnet version:"
husarnet version

# Join the Husarnet network, showing full command output for debugging
echo "Joining Husarnet network with JOIN_CODE=${HUSARNET_JOIN_CODE} and HOSTNAME=${HUSARNET_HOSTNAME}..."
husarnet join ${HUSARNET_JOIN_CODE} ${HUSARNET_HOSTNAME}

# Output the status of Husarnet to verify the connection
echo "Husarnet status:"
husarnet status

echo "Husarnet setup completed."

# Keep the container running to prevent it from exiting, as Railway might shut it down otherwise
echo "Entering idle state to keep the container alive..."
tail -f /dev/null
