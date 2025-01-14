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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServletException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation basique des champs
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Vérifier l'utilisateur avec la base de données
        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticateUser(email, password);

        if (user != null) {
            // Sauvegarder l'ID de l'utilisateur dans la session
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            System.out.println("user loged succesfully:"+user.getId());
            // Rediriger vers la page d'appréciation
            response.sendRedirect("appreciation.jsp");
        } else {
            // En cas d'échec, afficher un message d'erreur
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
