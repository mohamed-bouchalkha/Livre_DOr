package org.servlet.livre_dor.controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.servlet.livre_dor.models.User;
import org.servlet.livre_dor.models.UserDAO;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServletException, IOException {
        // Récupération des données du formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation basique des champs
        if (nom == null || prenom == null || email == null || password == null || nom.isEmpty() || prenom.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        // Enregistrer l'utilisateur dans la base de données
        User user = new User();
        user.setNom(nom);
        user.setPrenom(prenom);
        user.setEmail(email);
        user.setPassword(password); // Vous devriez hasher les mots de passe en production.

        // Simuler un DAO ou service (exemple simple)
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.save(user);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Erreur lors de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
    }
}
