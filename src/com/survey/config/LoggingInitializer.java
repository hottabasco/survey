package com.survey.config;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

@Startup
@Singleton
public class LoggingInitializer {

    @PostConstruct
    public void init() {
        try {
            // 1. Set up the file rotation logging system first
            Logger appLogger = Logger.getLogger("com.survey");
            String pattern = System.getProperty("catalina.base") + "/logs/survey-application-%g.log";
            FileHandler fileHandler = new FileHandler(pattern, 5242880, 5, true);
            
            fileHandler.setFormatter(new SimpleFormatter());
            fileHandler.setLevel(Level.INFO);

            appLogger.addHandler(fileHandler);
            appLogger.setLevel(Level.INFO);
            appLogger.setUseParentHandlers(false); 

            System.out.println("[Survey App] Log rotation initialized successfully.");

            // 2. Force DatabaseService class loading to happen NOW, 
            // safely after the logger has been attached!
            Class.forName("com.survey.service.DatabaseService");

        } catch (IOException | SecurityException | ClassNotFoundException e) {
            System.err.println("[Survey App] Initialization error: " + e.getMessage());
        }
    }
}

