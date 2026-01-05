# Dockerfile for CodeLab Tools development and production
FROM golang:1.23-alpine AS builder

# Install build dependencies
RUN apk add --no-cache \
    git \
    make \
    nodejs \
    npm

WORKDIR /build

# Copy Go module files first for better caching
COPY claat/go.mod claat/go.sum ./claat/
RUN cd claat && go mod download

# Copy all source code
COPY . .

# Build CLaaT
WORKDIR /build/claat
RUN make

# Production image
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache \
    ca-certificates \
    git

# Create non-root user
RUN addgroup -g 1000 claat && \
    adduser -D -u 1000 -G claat claat

WORKDIR /workspace

# Copy binary from builder
COPY --from=builder /build/claat/bin/claat /usr/local/bin/claat
RUN chmod +x /usr/local/bin/claat

# Switch to non-root user
USER claat

# Expose default serve port
EXPOSE 9090

# Default command
ENTRYPOINT ["claat"]
CMD ["--help"]
