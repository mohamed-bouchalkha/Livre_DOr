package org.servlet.livre_dor.controllers;

import org.servlet.livre_dor.models.Appreciation;
import org.servlet.livre_dor.models.AppreciationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/appreciations")
public class AppreciationController extends HttpServlet {
    private final AppreciationDAO dao = new AppreciationDAO();

    // Méthode pour gérer la soumission d'un nouveau formulaire d'appréciation
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String appreciation = request.getParameter("appreciation");

        Appreciation newAppreciation = new Appreciation();
        newAppreciation.setNom(nom);
        newAppreciation.setPrenom(prenom);
        newAppreciation.setAppreciation(appreciation);

        // Sauvegarde de l'appréciation dans la base de données
        dao.saveAppreciation(newAppreciation);
        response.sendRedirect("appreciations");
    }

    // Méthode pour gérer la récupération des appréciations et suppression
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Suppression d'une appréciation si l'ID est fourni dans la requête
        String deleteId = request.getParameter("id");
        if (deleteId != null) {
            try {
                int id = Integer.parseInt(deleteId);
                dao.deleteAppreciation(id); // Suppression de l'appréciation par son ID
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Récupération de toutes les appréciations
        List<Appreciation> appreciations = dao.getAllAppreciations();

        // Passer la liste d'appréciations à la vue JSP
        request.setAttribute("appreciations", appreciations);
        request.getRequestDispatcher("appreciations.jsp").forward(request, response);
    }

    // Méthode pour récupérer toutes les appréciations de la base de données
    public List<Appreciation> getAllAppreciations() {
        List<Appreciation> appreciations = new ArrayList<>();
        String sql = "SELECT * FROM appreciations"; // Requête SQL pour récupérer toutes les appréciations
        try (Connection connection = dao.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                // Création d'une nouvelle appréciation à partir des données récupérées de la base
                Appreciation appreciation = new Appreciation();
                appreciation.setId(rs.getInt("id"));
                appreciation.setNom(rs.getString("nom"));
                appreciation.setPrenom(rs.getString("prenom"));
                appreciation.setAppreciation(rs.getString("appreciation"));
                appreciation.setDate(rs.getTimestamp("date")); // Récupérer la date sous forme de Timestamp
                appreciations.add(appreciation); // Ajouter l'appréciation à la liste
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appreciations; // Retourner la liste d'appréciations
    }
}
