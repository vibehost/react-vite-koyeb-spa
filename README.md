# React Vite SPA - Koyeb Deployment

A React single-page application built with Vite and optimized for Koyeb Docker deployment.

## Features

- React 18 with hooks
- Vite for fast development and building
- Axios for HTTP requests
- Random quote fetching from external API
- Counter functionality
- Optimized Docker configuration for Koyeb
- Nginx with production-ready configuration
- Health check endpoint
- Security headers and performance optimizations

## Tech Stack

- React 18
- Vite 5
- Axios for API calls
- Nginx (Alpine) for production serving
- Docker multi-stage build

## Local Development

```bash
npm install
npm run dev
```

## Building

```bash
npm run build
```

The built files will be in the `dist` directory.

## Preview

```bash
npm run preview
```

This will serve the built application locally.

## Docker Deployment

### Building the Docker Image

```bash
docker build -t react-vite-spa-koyeb .
```

### Running the Container

```bash
docker run -p 8000:8000 -e PORT=8000 react-vite-spa-koyeb
```

## Koyeb Deployment

This project is optimized for Koyeb Docker deployment with the following features:

- **Multi-stage Docker build** for optimal image size
- **Dynamic port configuration** using environment variables
- **Health check endpoint** at `/health`
- **Production-ready nginx configuration** with:
  - Gzip compression
  - Static asset caching
  - Security headers
  - SPA routing support
- **Optimized Vite build** with code splitting

### Deployment Steps

1. Push your code to a Git repository
2. Create a new Koyeb app
3. Select Docker deployment
4. Point to your repository
5. Set the port to the PORT environment variable (automatically handled)
6. Deploy!

### Environment Variables

- `PORT`: The port the application will run on (automatically set by Koyeb)

### Health Check

The application includes a health check endpoint at `/health` that returns a 200 status with "healthy" message.

## Performance Features

- Code splitting with separate vendor and utility chunks
- Gzip compression
- Static asset caching (1 year for assets, 5 minutes for HTML)
- Optimized nginx configuration
- Security headers including CSP

## Test Checklist

- [x] App loads without errors
- [x] Counter increments when clicked
- [x] Quote fetches from external API
- [x] Responsive design works
- [x] Production build serves correctly
- [x] Docker build optimized for Koyeb
- [x] Health check endpoint available
- [x] Security headers configured