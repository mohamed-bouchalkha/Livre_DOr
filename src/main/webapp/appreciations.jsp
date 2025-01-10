<%@ page import="java.util.List" %>
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des appréciations</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="container mx-auto px-6 py-12">
    <h2 class="text-3xl font-bold text-center text-gray-800 mb-8">Appréciations des utilisateurs</h2>

    <section class="max-h-96 overflow-y-auto space-y-4">
        <%
            // Récupérer la liste des appréciations passées par le contrôleur
            List<Appreciation> appreciations = (List<org.servlet.livre_dor.models.Appreciation>) request.getAttribute("appreciations");

            // Afficher chaque appréciation
            for (org.servlet.livre_dor.models.Appreciation appreciation : appreciations) {
        %>
        <div class="bg-white p-6 rounded-lg shadow-md border border-gray-200">
            <p class="text-lg font-semibold text-gray-800">
                <%= appreciation.getNom() %> <%= appreciation.getPrenom() %> -
                <span class="text-sm text-gray-500"><%= appreciation.getDate() %></span>
            </p>
            <p class="mt-4 text-gray-700"><%= appreciation.getAppreciation() %></p>

            <!-- Boutons Modifier et Supprimer -->
            <div class="mt-4 flex justify-end space-x-4">
                <!-- Lien pour la modification -->
                <a href="modifier.jsp?id=<%= appreciation.getId() %>" class="text-blue-500 hover:text-blue-700 font-semibold">Modifier</a>

                <!-- Lien pour la suppression -->
                <a href="appreciations?id=<%= appreciation.getId() %>" class="text-red-500 hover:text-red-700 font-semibold"
                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette appréciation ?')">Supprimer</a>
            </div>
        </div>
        <% } %>
    </section>

    <!-- Lien pour ajouter une nouvelle appréciation -->
    <div class="text-center mt-6">
        <a href="index.jsp" class="text-blue-500 hover:text-blue-700 font-semibold">Ajouter une nouvelle appréciation</a>
    </div>
</div>

</body>
</html>
