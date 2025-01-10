<!-- appreciation.jsp -->
<%@ page import="java.util.List" %>
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livre d'Or - Appréciations</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<!-- En-tête -->
<header class="bg-white shadow-sm">
    <div class="max-w-7xl mx-auto px-4 py-6">
        <div class="flex justify-between items-center">
            <h1 class="text-3xl font-bold text-gray-900">Livre d'Or</h1>
            <a href="index.jsp" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors">
                <i class="fas fa-plus mr-2"></i> Nouvelle appréciation
            </a>
        </div>
    </div>
</header>

<main class="max-w-7xl mx-auto px-4 py-8">
    <!-- Liste des appréciations -->
    <div class="grid gap-6">
        <%
            List<Appreciation> appreciations = (List<Appreciation>) request.getAttribute("appreciations");
            for (Appreciation appreciation : appreciations) {
        %>
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 transition-all hover:shadow-md">
            <div class="flex justify-between items-start">
                <div>
                    <h3 class="text-lg font-semibold text-gray-900">
                        <%= appreciation.getNom() %> <%= appreciation.getPrenom() %>
                    </h3>
                    <p class="text-sm text-gray-500 mt-1">
                        <i class="far fa-calendar mr-2"></i>
                        <%= appreciation.getDate() %>
                    </p>
                </div>
                <div class="flex gap-2">
                    <a href="modifier.jsp?id=<%= appreciation.getId() %>"
                       class="text-gray-600 hover:text-blue-600 p-2 rounded-full hover:bg-blue-50 transition-colors">
                        <i class="fas fa-edit"></i>
                    </a>
                    <button onclick="confirmerSuppression(<%= appreciation.getId() %>)"
                            class="text-gray-600 hover:text-red-600 p-2 rounded-full hover:bg-red-50 transition-colors">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            <p class="mt-4 text-gray-700 leading-relaxed">
                <%= appreciation.getAppreciation() %>
            </p>
        </div>
        <% } %>
    </div>
</main>

<script>
    function confirmerSuppression(id) {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette appréciation ?')) {
            window.location.href = 'appreciations?id=' + id;
        }
    }
</script>
</body>
</html>