@echo off
REM Build and run Survey Application with Docker

echo ================================
echo Survey Application Docker Setup
echo ================================

REM Check if Docker is running
docker --version >nul 2>&1
if errorlevel 1 (
    echo Error: Docker is not installed or not running
    echo Please install Docker Desktop and make sure it's running
    pause
    exit /b 1
)

REM Build the Docker image
echo.
echo Building Docker image...
docker build -t survey-app:latest .

if errorlevel 1 (
    echo Error: Failed to build Docker image
    pause
    exit /b 1
)

echo.
echo Build successful!

REM Ask user what to do
echo.
echo What would you like to do?
echo 1. Run with docker run
echo 2. Run with docker-compose
echo 3. Just build (exit)
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" (
    echo.
    echo Starting application with docker run...
    echo Application will be available at: http://localhost:8080
    echo Press Ctrl+C to stop the application
    echo.
    docker run --rm -p 8080:8080 --name survey-app survey-app:latest
) else if "%choice%"=="2" (
    echo.
    echo Starting application with docker-compose...
    echo Application will be available at: http://localhost:8080
    echo Use 'docker-compose down' to stop the application
    echo.
    docker-compose up
) else (
    echo.
    echo Build completed. You can run the application with:
    echo   docker run -p 8080:8080 survey-app:latest
    echo or
    echo   docker-compose up
    echo.
)

pause