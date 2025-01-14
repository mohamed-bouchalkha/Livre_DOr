package org.servlet.livre_dor.controllers;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.servlet.livre_dor.models.AppreciationDAO;

import java.io.IOException;

@WebServlet("/deleteAppreciation")
public class DeleteAppreciationServlet extends HttpServlet {
    private final AppreciationDAO appreciationDAO = new AppreciationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Appeler la méthode DAO pour supprimer
        appreciationDAO.delete(id);

        response.sendRedirect("appreciation.jsp");
    }
}
