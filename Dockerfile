# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy app files
COPY package*.json ./
RUN npm install
COPY . .

# Expose port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
