# Survey Application - Docker Setup

## Mô tả
Đây là ứng dụng Java Servlet survey chạy trên Apache Tomcat 10.1 với JDK 17.

## Cấu trúc dự án
```
ch06_ex2_survey/
├── web/                    # Web application files
│   ├── index.html         # Form survey
│   ├── survey.jsp         # Trang hiển thị kết quả
│   ├── WEB-INF/
│   │   ├── web.xml        # Web app configuration
│   │   └── classes/       # Compiled Java classes
│   └── styles/            # CSS files
├── src/                   # Source code
├── Dockerfile             # Docker configuration
└── .dockerignore         # Docker ignore file
```

## Cài đặt Docker

### Windows
1. Tải Docker Desktop từ: https://docs.docker.com/desktop/windows/install/
2. Cài đặt và khởi động Docker Desktop
3. Mở PowerShell và chạy `docker --version` để kiểm tra

### Các lệnh Docker để build và chạy

```bash
# Build Docker image
docker build -t survey-app .

# Chạy container
docker run -d -p 8080:8080 --name survey-container survey-app

# Kiểm tra container đang chạy
docker ps

# Xem logs
docker logs survey-container

# Dừng container
docker stop survey-container

# Xóa container
docker rm survey-container

# Xóa image
docker rmi survey-app
```

## Truy cập ứng dụng
Sau khi chạy container, truy cập: http://localhost:8080

## Chức năng
1. Điền form survey tại trang chính
2. Click Submit để gửi dữ liệu
3. Xem kết quả trên trang survey.jsp

## Cấu hình Dockerfile
- Base image: `tomcat:10.1-jdk17`
- Port: 8080
- Web application được deploy như ROOT application
- Tự động khởi động Tomcat khi container chạy