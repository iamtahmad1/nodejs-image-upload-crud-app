# Use a smaller base image like node:18-alpine
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if exists) for dependencies
COPY package*.json ./

# Install dependencies (production-only)
RUN npm install --production

# Copy the rest of the application
COPY . .

# Start a new stage for the production image
FROM node:18-alpine

# Set working directory for the final image
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose port
EXPOSE 5000

# Start the application (using node in production)
CMD ["node", "main.js"]
