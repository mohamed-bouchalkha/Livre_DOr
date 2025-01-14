package org.servlet.livre_dor.controllers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.servlet.livre_dor.models.AppreciationDAO;

import java.io.IOException;

@WebServlet("/editAppreciation")
public class EditAppreciationServlet extends HttpServlet {
    private final AppreciationDAO appreciationDAO = new AppreciationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String appreciationText = request.getParameter("appreciation");

        // Appeler la méthode DAO pour mettre à jour
        appreciationDAO.update(id, appreciationText);

        response.sendRedirect("appreciation.jsp");
    }
}

