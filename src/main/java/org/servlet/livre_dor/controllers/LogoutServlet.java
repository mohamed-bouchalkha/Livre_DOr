package org.servlet.livre_dor.controllers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.servlet.livre_dor.models.AppreciationDAO;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, IOException {
        // Récupérer la session actuelle
        HttpSession session = request.getSession(false);

        // Si la session existe, on l'invalide
        if (session != null) {
            session.invalidate();
        }

        // Rediriger l'utilisateur vers la page de login après déconnexion
        response.sendRedirect("login.jsp");
    }
}
