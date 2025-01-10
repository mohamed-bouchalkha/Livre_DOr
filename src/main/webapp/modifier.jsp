<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page import="org.servlet.livre_dor.models.AppreciationDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier l'appréciation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="container mx-auto px-6 py-12">
    <h2 class="text-3xl font-bold text-center text-gray-800 mb-8">Modifier l'appréciation</h2>

    <%
        // Récupérer l'ID de l'appréciation à modifier
        String idString = request.getParameter("id");
        if (idString != null) {
            int id = Integer.parseInt(idString);

            // Récupérer l'appréciation à modifier via le DAO
            AppreciationDAO dao = new AppreciationDAO();
            Appreciation appreciation = dao.getAppreciationById(id);
    %>

    <!-- Formulaire de modification -->
    <form action="appreciations" method="post" class="bg-white p-6 rounded-lg shadow-md border border-gray-200">
        <input type="hidden" name="id" value="<%= appreciation.getId() %>">

        <div class="mb-4">
            <label for="nom" class="block text-gray-700">Nom :</label>
            <input type="text" id="nom" name="nom" value="<%= appreciation.getNom() %>" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg">
        </div>

        <div class="mb-4">
            <label for="prenom" class="block text-gray-700">Prénom :</label>
            <input type="text" id="prenom" name="prenom" value="<%= appreciation.getPrenom() %>" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg">
        </div>

        <div class="mb-4">
            <label for="appreciation" class="block text-gray-700">Appréciation :</label>
            <textarea id="appreciation" name="appreciation" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg"><%= appreciation.getAppreciation() %></textarea>
        </div>

        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
            Modifier l'appréciation
        </button>
    </form>

    <%
        } else {
            out.println("<p class='text-red-500'>Erreur : ID non valide.</p>");
        }
    %>

    <div class="text-center mt-6">
        <a href="appreciations" class="text-blue-500 hover:text-blue-700 font-semibold">Retour à la liste des appréciations</a>
    </div>
</div>

</body>
</html>
