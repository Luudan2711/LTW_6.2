# PowerShell script để build và chạy Docker container

Write-Host "=== Survey App Docker Management ===" -ForegroundColor Green

# Kiểm tra Docker có sẵn không
try {
    docker --version | Out-Null
    Write-Host "✓ Docker đã được cài đặt" -ForegroundColor Green
}
catch {
    Write-Host "✗ Docker chưa được cài đặt. Vui lòng cài Docker Desktop trước." -ForegroundColor Red
    Write-Host "Download: https://docs.docker.com/desktop/windows/install/" -ForegroundColor Yellow
    exit 1
}

# Menu lựa chọn
Write-Host "`nChọn hành động:"
Write-Host "1. Build Docker image"
Write-Host "2. Run container"
Write-Host "3. Stop container"
Write-Host "4. View logs"
Write-Host "5. Clean up (stop + remove)"
Write-Host "6. Build và run (all-in-one)"

$choice = Read-Host "`nNhập lựa chọn (1-6)"

$imageName = "survey-app"
$containerName = "survey-container"

switch ($choice) {
    "1" {
        Write-Host "Building Docker image..." -ForegroundColor Yellow
        docker build -t $imageName .
        Write-Host "✓ Build completed!" -ForegroundColor Green
    }
    "2" {
        Write-Host "Starting container..." -ForegroundColor Yellow
        docker run -d -p 8080:8080 --name $containerName $imageName
        Write-Host "✓ Container started!" -ForegroundColor Green
        Write-Host "Access app at: http://localhost:8080" -ForegroundColor Cyan
    }
    "3" {
        Write-Host "Stopping container..." -ForegroundColor Yellow
        docker stop $containerName
        Write-Host "✓ Container stopped!" -ForegroundColor Green
    }
    "4" {
        Write-Host "Container logs:" -ForegroundColor Yellow
        docker logs $containerName
    }
    "5" {
        Write-Host "Cleaning up..." -ForegroundColor Yellow
        docker stop $containerName 2>$null
        docker rm $containerName 2>$null
        Write-Host "✓ Cleanup completed!" -ForegroundColor Green
    }
    "6" {
        Write-Host "Build and run..." -ForegroundColor Yellow
        # Stop và remove container cũ nếu có
        docker stop $containerName 2>$null
        docker rm $containerName 2>$null
        
        # Build image
        docker build -t $imageName .
        
        # Run container
        docker run -d -p 8080:8080 --name $containerName $imageName
        
        Write-Host "✓ All done!" -ForegroundColor Green
        Write-Host "Access app at: http://localhost:8080" -ForegroundColor Cyan
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")