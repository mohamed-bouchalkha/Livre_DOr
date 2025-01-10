package org.servlet.livre_dor.models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppreciationDAO {
    private static final String URL = "jdbc:postgresql://localhost:5432/LivreDor";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin123";

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public void saveAppreciation(Appreciation appreciation) {
        String sql = "INSERT INTO appreciations (nom, prenom, appreciation, date) VALUES (?, ?, ?, ?)";

        // Définir la date actuelle
        appreciation.setCurrentDate(); // Définir la date avant l'insertion

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, appreciation.getNom());
            statement.setString(2, appreciation.getPrenom());
            statement.setString(3, appreciation.getAppreciation());
            statement.setTimestamp(4, new Timestamp(appreciation.getDate().getTime())); // Convertir la date en Timestamp

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la sauvegarde de l'appréciation.", e);
        }
    }

    public List<Appreciation> getAllAppreciations() {
        List<Appreciation> appreciations = new ArrayList<>();
        String sql = "SELECT * FROM appreciations";
        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Appreciation appreciation = new Appreciation();
                appreciation.setId(rs.getInt("id"));
                appreciation.setNom(rs.getString("nom"));
                appreciation.setPrenom(rs.getString("prenom"));
                appreciation.setAppreciation(rs.getString("appreciation"));
                appreciation.setDate(rs.getTimestamp("date")); // Récupérer la date de la base de données
                appreciations.add(appreciation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appreciations;
    }
    public Appreciation getAppreciationById(int id) {
        Appreciation appreciation = null;
        String sql = "SELECT * FROM appreciations WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                appreciation = new Appreciation();
                appreciation.setId(resultSet.getInt("id"));
                appreciation.setNom(resultSet.getString("nom"));
                appreciation.setPrenom(resultSet.getString("prenom"));
                appreciation.setAppreciation(resultSet.getString("appreciation"));
                appreciation.setDate(resultSet.getTimestamp("date")); // Ajustez selon la façon dont la date est stockée
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la récupération de l'appréciation.", e);
        }

        return appreciation;
    }
    public void deleteAppreciation(int id) {
        String sql = "DELETE FROM appreciations WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la suppression de l'appréciation.", e);
        }
    }


}
