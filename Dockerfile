# ---- Build stage ----
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with production optimizations
RUN npm ci --only=production --silent && \
    npm cache clean --force

# Copy source code
COPY . .

# Build the application
RUN npm run build

# ---- Production stage ----
FROM nginx:alpine

# Install envsubst for dynamic configuration and set timezone
RUN apk add --no-cache gettext tzdata && \
    rm -rf /var/cache/apk/*

# Copy built application
COPY --from=builder /app/dist /usr/share/nginx/html

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy nginx configuration template
COPY nginx.conf.template /etc/nginx/templates/

# Create nginx user and set permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Set default port (Koyeb will override this with PORT env var)
ENV PORT=8000

# Expose port
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:$PORT/ || exit 1

# Use nginx with automatic template processing
CMD ["sh", "-c", "envsubst '$PORT' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
