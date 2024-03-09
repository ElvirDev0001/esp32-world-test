# Start from the official Python image
FROM python:3.12.1

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    HUSARNET_JOIN_CODE="fc94:b01d:1803:8dd8:b293:5c7d:7639:932a/QMEiPq5h884GkJy3FuRqCW" \
    HUSARNET_HOSTNAME="awesome-chips"

# Set the working directory in the container
WORKDIR /app

# Copy the Python dependencies file to the container and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Install Husarnet dependencies and Husarnet itself
# Adding apt-get install commands in a single RUN to reduce layers and using DEBIAN_FRONTEND=noninteractive to avoid tzdata prompt
RUN apt-get update && apt-get install -y sudo systemd gnupg2 curl && \
    curl https://install.husarnet.com/install.sh | bash -s -- --verbose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of your application's code
COPY . .

# Expose the port your app runs on
EXPOSE 8000

# Ensure entrypoint.sh is executable
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Use Gunicorn to serve the Flask app; adjust the number of workers as needed
CMD ["gunicorn", "-w", "4", "main:app", "-b", "0.0.0.0:8000"]
