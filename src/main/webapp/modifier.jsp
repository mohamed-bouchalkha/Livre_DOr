<!-- modifier.jsp -->
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page import="org.servlet.livre_dor.models.AppreciationDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livre d'Or - Modifier l'appréciation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<jsp:include page="header.jsp" />

<main class="max-w-3xl mx-auto px-4 py-8">
    <%
        String idString = request.getParameter("id");
        if (idString != null) {
            int id = Integer.parseInt(idString);
            AppreciationDAO dao = new AppreciationDAO();
            Appreciation appreciation = dao.getAppreciationById(id);
            if (appreciation != null) {
    %>
    <div class="mb-6">
        <h2 class="text-2xl font-bold text-gray-900">Modifier l'appréciation</h2>
        <p class="mt-2 text-gray-600">Mettez à jour votre message</p>
    </div>

    <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <form action="appreciations" method="post" class="space-y-6">
            <input type="hidden" name="id" value="<%= appreciation.getId() %>">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                    <input type="text" id="nom" name="nom" value="<%= appreciation.getNom() %>" required
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                </div>
                <div>
                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                    <input type="text" id="prenom" name="prenom" value="<%= appreciation.getPrenom() %>" required
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500">
                </div>
            </div>

            <div>
                <label for="appreciation" class="block text-sm font-medium text-gray-700">Votre appréciation</label>
                <textarea id="appreciation" name="appreciation" rows="5" required
                          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"><%= appreciation.getAppreciation() %></textarea>
            </div>

            <div class="flex justify-end gap-4">
                <a href="appreciations"
                   class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md text-gray-700 bg-white hover:bg-gray-50">
                    <i class="fas fa-times mr-2"></i> Annuler
                </a>
                <button type="submit"
                        class="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
                    <i class="fas fa-save mr-2"></i> Enregistrer
                </button>
            </div>
        </form>
    </div>
    <%
    } else {
    %>
    <div class="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
        <i class="fas fa-exclamation-circle mr-2"></i>
        L'appréciation demandée n'existe pas.
    </div>
    <%
        }
    } else {
    %>
    <div class="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
        <i class="fas fa-exclamation-circle mr-2"></i>
        ID non valide.
    </div>
    <%
        }
    %>
</main>
</body>
</html>