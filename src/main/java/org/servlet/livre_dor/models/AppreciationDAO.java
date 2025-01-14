    package org.servlet.livre_dor.models;

    import java.sql.*;
    import java.util.ArrayList;
    import java.util.List;

    public class AppreciationDAO {

        public List<Appreciation> getAllAppreciations() {
            List<Appreciation> appreciations = new ArrayList<>();
            String query = "SELECT a.id, a.appreciation, a.date, u.nom, u.prenom, u.id as user_id " +
                    "FROM appreciations a " +
                    "JOIN users u ON a.user_id = u.id";

            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement stmt = connection.prepareStatement(query)) {

                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    // Créer l'objet User
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setNom(rs.getString("nom"));
                    user.setPrenom(rs.getString("prenom"));

                    // Créer l'objet Appreciation
                    Appreciation appreciation = new Appreciation();
                    appreciation.setId(rs.getInt("id"));
                    appreciation.setUser(user);
                    appreciation.setAppreciation(rs.getString("appreciation"));
                    appreciation.setDate(rs.getDate("date"));

                    appreciations.add(appreciation);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            return appreciations;
        }



        // Méthode pour ajouter une nouvelle appréciation
        public void save(Appreciation appreciation) {
            String query = "INSERT INTO appreciations (user_id, appreciation, date) VALUES (?, ?, ?)";

            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement stmt = connection.prepareStatement(query)) {

                stmt.setInt(1, appreciation.getUser().getId());
                stmt.setString(2, appreciation.getAppreciation());
                stmt.setDate(3, new Date(appreciation.getDate().getTime()));

                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        public void delete(int id) {
            String query = "DELETE FROM appreciations WHERE id = ?";

            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement stmt = connection.prepareStatement(query)) {

                stmt.setInt(1, id);
                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        public void update(int id, String appreciation) {
            String query = "UPDATE appreciations SET appreciation = ? WHERE id = ?";

            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement stmt = connection.prepareStatement(query)) {

                stmt.setString(1, appreciation);
                stmt.setInt(2, id);
                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
