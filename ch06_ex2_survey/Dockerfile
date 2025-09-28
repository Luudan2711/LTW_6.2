# Multi-stage Dockerfile cho Survey Application

# Stage 1: Build stage (nếu cần compile)
FROM openjdk:17-jdk-slim AS build

# Copy source code (nếu cần build)
WORKDIR /app
COPY src/ ./src/

# Stage 2: Runtime stage
FROM tomcat:10.1-jdk17-openjdk-slim

# Metadata
LABEL maintainer="Survey App"
LABEL description="Java Servlet Survey Application with Tomcat 10"

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy web application to ROOT (để truy cập qua http://localhost:8080/)
COPY web/ /usr/local/tomcat/webapps/ROOT/

# Set environment variables
ENV CATALINA_OPTS="-Xmx512m -Xms256m"
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"

# Create non-root user for security
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat
RUN chown -R tomcat:tomcat /usr/local/tomcat
USER tomcat

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]