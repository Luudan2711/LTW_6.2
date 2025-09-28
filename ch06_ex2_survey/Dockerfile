# Multi-stage Dockerfile for Survey Web Application
# Optimized for Render.com deployment

# Stage 1: Build application with Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration first for better layer caching
COPY pom.xml .
COPY .mvn .mvn/
COPY mvnw.cmd .

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests -q

# Stage 2: Runtime with Tomcat
FROM tomcat:10.1-jdk17-openjdk-slim AS runtime

# Create non-root user for security
RUN groupadd -r tomcat && useradd -r -g tomcat -s /bin/false tomcat

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR file from build stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Set environment variables for Render
ENV CATALINA_OPTS="-Xmx512m -Xms256m -server"
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"

# Create logs directory and set permissions
RUN mkdir -p /usr/local/tomcat/logs && \
    chown -R tomcat:tomcat /usr/local/tomcat && \
    chmod -R 755 /usr/local/tomcat

# Switch to non-root user
USER tomcat

# Expose port (Render will bind to this port)
EXPOSE 8080

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]