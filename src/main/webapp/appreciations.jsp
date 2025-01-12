
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
<jsp:include page="header.jsp" />

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="mb-6 flex justify-between items-center">
        <h2 class="text-2xl font-bold text-gray-900">Toutes les appréciations</h2>
        <a href="index.jsp" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
            <i class="fas fa-plus mr-2"></i> Nouvelle appréciation
        </a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <%
            List<Appreciation> appreciations = (List<Appreciation>) request.getAttribute("appreciations");
            for (Appreciation appreciation : appreciations) {
        %>
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-4 hover:shadow-md transition-all">
            <div class="flex justify-between items-start mb-3">
                <div>
                    <h3 class="text-lg font-semibold text-gray-900">
                        <%= appreciation.getNom() %> <%= appreciation.getPrenom() %>
                    </h3>
                    <p class="text-sm text-gray-500">
                        <i class="far fa-calendar mr-1"></i>
                        <%= appreciation.getDate() %>
                    </p>
                </div>
                <div class="flex gap-1">
                    <button onclick="toggleFavori(this)" class="text-gray-400 hover:text-yellow-500 p-1">
                        <i class="far fa-star"></i>
                    </button>
                    <a href="modifier.jsp?id=<%= appreciation.getId() %>"
                       class="text-gray-400 hover:text-blue-600 p-1">
                        <i class="fas fa-edit"></i>
                    </a>
                    <button onclick="confirmerSuppression(<%= appreciation.getId() %>)"
                            class="text-gray-400 hover:text-red-600 p-1">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            <p class="text-gray-700 text-sm line-clamp-3">
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

    function toggleFavori(button) {
        const icon = button.querySelector('i');
        if (icon.classList.contains('far')) {
            icon.classList.remove('far');
            icon.classList.add('fas');
            icon.classList.add('text-yellow-500');
        } else {
            icon.classList.remove('fas');
            icon.classList.remove('text-yellow-500');
            icon.classList.add('far');
        }
    }
</script>
</body>
</html>