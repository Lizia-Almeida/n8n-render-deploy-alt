FROM node:18-alpine

# Install system dependencies required by n8n
RUN apk add --no-cache python3 make g++ curl bash

# Create a working directory
WORKDIR /home/node/app

# Install n8n globally (as root, with permission)
RUN npm install -g n8n

# Define runtime environment variables (not evaluated at build-time)
ENV DB_SQLITE_DATABASE=/tmp/database.sqlite
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=supersecretpassword
ENV N8N_HOST=0.0.0.0
ENV N8N_PATH=/
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Drop to the pre-existing non-root user 'node'
USER node

# Start n8n with shell context, so $PORT resolves dynamically at runtime
CMD ["sh", "-c", "n8n start"]
