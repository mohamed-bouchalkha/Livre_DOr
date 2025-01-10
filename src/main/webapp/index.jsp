<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une appréciation</title>
    <!-- Ajout de Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<header class="bg-blue-600 text-white py-6 text-center">
    <div class="container mx-auto">
        <h1 class="text-3xl font-semibold">Livre d'Or</h1>
        <p class="mt-2 text-xl">Partagez vos appréciations avec le monde !</p>
    </div>
</header>

<main>
    <div class="container mx-auto px-4 py-8">
        <section class="form-section bg-white p-6 rounded-lg shadow-lg">
            <h2 class="text-2xl font-semibold mb-4">Ajouter une nouvelle appréciation</h2>
            <form action="appreciations" method="POST" class="space-y-4">
                <div class="form-group">
                    <label for="nom" class="block text-lg">Nom :</label>
                    <input type="text" name="nom" id="nom" class="w-full p-3 border border-gray-300 rounded-md" required>
                </div>
                <div class="form-group">
                    <label for="prenom" class="block text-lg">Prénom :</label>
                    <input type="text" name="prenom" id="prenom" class="w-full p-3 border border-gray-300 rounded-md" required>
                </div>
                <div class="form-group">
                    <label for="appreciation" class="block text-lg">Appréciation :</label>
                    <textarea name="appreciation" id="appreciation" rows="5" class="w-full p-3 border border-gray-300 rounded-md" required></textarea>
                </div>
                <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-md hover:bg-blue-700">Publier</button>
                <div class="flex justify-center space-x-4">
                    <a href="appreciations" class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-700">Voir les appréciations</a>
                </div>
            </form>

        </section>
    </div>
</main>

<footer class="bg-gray-800 text-white text-center py-4 mt-8">
    <p>&copy; 2025 Livre d'Or - Tous droits réservés</p>
</footer>

</body>
</html>
