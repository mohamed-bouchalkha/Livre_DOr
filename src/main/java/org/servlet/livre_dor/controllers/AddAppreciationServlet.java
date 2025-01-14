package org.servlet.livre_dor.controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.servlet.livre_dor.models.Appreciation;
import org.servlet.livre_dor.models.AppreciationDAO;
import org.servlet.livre_dor.models.User;

import java.io.IOException;
import java.util.Date;

@WebServlet("/addAppreciation")
public class AddAppreciationServlet extends HttpServlet {

    private final AppreciationDAO appreciationDAO = new AppreciationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String appreciationText = request.getParameter("appreciation");

        if (appreciationText == null || appreciationText.trim().isEmpty()) {
            response.sendRedirect("appreciation.jsp?error=empty");
            return;
        }

        User user = new User();
        user.setId(userId);

        Appreciation appreciation = new Appreciation();
        appreciation.setUser(user);
        appreciation.setAppreciation(appreciationText);
        appreciation.setDate(new Date());

        appreciationDAO.save(appreciation);

        response.sendRedirect("appreciation.jsp");
    }
}

