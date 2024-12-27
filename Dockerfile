# Use a smaller base image like node:18-alpine
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if exists) for dependencies
COPY package*.json ./

# Install dependencies (in a separate layer to leverage caching)
RUN npm install --production

# Copy the rest of the application
COPY . .

# Build your application if necessary (e.g., for React/Vue, etc.)
# RUN npm run build (skip if not needed)

# Start a new stage for the production image
FROM node:18-alpine

# Set working directory for the final image
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
