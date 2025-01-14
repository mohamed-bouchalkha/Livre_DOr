//package org.servlet.livre_dor.controllers;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import org.servlet.livre_dor.models.Appreciation;
//import org.servlet.livre_dor.models.AppreciationDAO;
//import org.servlet.livre_dor.models.User;
//import org.servlet.livre_dor.models.UserDAO;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/appreciations")
//public class AppreciationServlet extends HttpServlet {
//
//    private AppreciationDAO appreciationDAO = new AppreciationDAO();
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
//        // Récupérer toutes les appréciations depuis le DAO
//        List<Appreciation> appreciations = appreciationDAO.getAllAppreciations();
//
//        // Passer les appréciations à la JSP
//        request.setAttribute("appreciations", appreciations);
//
//        // Afficher la page JSP
//        request.getRequestDispatcher("/appreciations.jsp").forward(request, response);
//    }
//}
