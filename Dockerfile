# Multi-stage Dockerfile for react frontend

# Builder stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy manifest and lock files
COPY package*.json ./
RUN npm install

# Copy all sources
COPY . .
RUN npm run build

FROM nginx:alpine AS production

# Copy static assets for serving
COPY --from=builder /app/build /usr/share/nginx/html

# Optional: Copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 # for react and vite only
CMD ["nginx", "-g", "daemon off;"]
