@echo off
echo Building Survey Web Application...

echo.
echo Step 1: Cleaning previous builds...
if exist target rmdir /s /q target

echo.
echo Step 2: Building Docker image...
docker build -t survey-app .

if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo Step 3: Running container...
echo Starting application on http://localhost:8080
echo Press Ctrl+C to stop
docker run -p 8080:8080 --rm survey-app