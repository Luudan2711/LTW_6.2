package com.murach.main;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import java.io.File;

public class EmbeddedTomcatServer {

    public static void main(String[] args) throws Exception {
        // Get port from environment variable (for Render deployment)
        String portStr = System.getenv("PORT");
        int port = portStr != null ? Integer.parseInt(portStr) : 8080;

        // Create Tomcat instance
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.getConnector(); // Trigger creation of the default connector

        // Get webapp directory from classpath
        String webappDir;
        try {
            // Try to get webapp from classpath (for packaged JAR)
            webappDir = EmbeddedTomcatServer.class.getClassLoader()
                .getResource("webapp").getPath();
        } catch (Exception e) {
            // Fallback to file system
            webappDir = new File("src/main/resources/webapp").getAbsolutePath();
            if (!new File(webappDir).exists()) {
                webappDir = new File("web").getAbsolutePath();
            }
        }

        // Add webapp to tomcat
        Context ctx = tomcat.addWebapp("/", webappDir);
        
        // Set up resources
        File additionWebInfClasses = new File("target/classes");
        if (additionWebInfClasses.exists()) {
            StandardRoot resources = new StandardRoot(ctx);
            resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                    additionWebInfClasses.getAbsolutePath(), "/"));
            ctx.setResources(resources);
        }

        System.out.println("Starting Tomcat server on port: " + port);
        System.out.println("Webapp directory: " + webappDir);
        
        tomcat.start();
        tomcat.getServer().await();
    }
}