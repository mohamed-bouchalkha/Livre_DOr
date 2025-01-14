package org.servlet.livre_dor.models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:postgresql://localhost:5432/LivreDorv2";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin123";
    private static final String DRIVER = "org.postgresql.Driver";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);  // Charger le driver PostgreSQL
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver PostgreSQL non trouvé", e);
        }
    }
}
