# Survey Web Application

A Java Servlet and JSP web application for collecting user survey data.

## 🚀 Features

- User-friendly survey form
- Servlet-based form processing
- JSP result display
- Jakarta EE compatible
- Dockerized deployment
- Ready for cloud deployment

## 🛠️ Technology Stack

- **Java 17** - Programming language
- **Jakarta Servlet API 6.0** - Web framework
- **JSP 3.1** - View technology
- **JSTL 3.0** - JSP Standard Tag Library
- **Apache Tomcat 10.1** - Servlet container
- **Maven 3.9** - Build tool
- **Docker** - Containerization

## 🏗️ Project Structure

```
ch06_ex2_survey/
├── src/main/
│   ├── java/
│   │   └── murach/
│   │       ├── business/User.java
│   │       └── controllers/SurveyServlet.java
│   └── webapp/
│       ├── index.html
│       ├── survey.jsp
│       ├── WEB-INF/web.xml
│       └── styles/main.css
├── pom.xml
├── Dockerfile
├── render.yaml
└── README.md
```

## 🚀 Deployment to Render

### Prerequisites
1. GitHub repository with your code
2. Render account (free tier available)

### Steps to Deploy:

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin <your-github-repo-url>
   git push -u origin main
   ```

2. **Deploy on Render:**
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file
   - Click "Create Web Service"

3. **Configuration (Auto-configured via render.yaml):**
   - Runtime: Docker
   - Build Command: Automatically handled by Dockerfile
   - Start Command: Automatically handled by Dockerfile
   - Port: 8080
   - Health Check: `/`

### Environment Variables (Pre-configured):
- `JAVA_OPTS`: JVM optimization settings
- `CATALINA_OPTS`: Tomcat optimization settings

## 💻 Local Development

### Using Maven:
```bash
# Compile
mvn compile

# Package as WAR
mvn clean package

# Run tests
mvn test
```

### Using Docker:
```bash
# Build image
docker build -t survey-app .

# Run container
docker run -p 8080:8080 survey-app

# Access application
open http://localhost:8080
```

### Manual Deployment to Tomcat:
1. Build WAR: `mvn clean package`
2. Copy `target/ch06-ex2-survey.war` to Tomcat `webapps/`
3. Start Tomcat
4. Access: `http://localhost:8080/ch06-ex2-survey/`

## 🔧 Application Features

### Survey Form (`index.html`):
- First Name, Last Name, Email (required)
- Radio buttons: How did you hear about us?
- Checkbox: Want updates?
- Dropdown: Contact preference

### Form Processing (`SurveyServlet`):
- Validates and processes form data
- Handles null values for optional fields
- Creates User object with survey data
- Forwards to result page

### Result Display (`survey.jsp`):
- Shows submitted survey data
- Uses JSP Expression Language (EL)
- Professional formatting

## 🌐 Live Demo

After deployment, your app will be available at:
`https://your-service-name.onrender.com`

## 📝 License

This project is for educational purposes as part of Murach's Java Servlets and JSP course material.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

For deployment issues, check:
- Render logs in dashboard
- Docker build logs

- Application health check status

