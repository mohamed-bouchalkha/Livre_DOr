<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Livre d'Or</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Ajouter les liens pour Toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body class="bg-gray-50">

<main class="font-[sans-serif] relative">
    <div class="h-[240px] font-[sans-serif]">
        <img src="https://readymadeui.com/cardImg.webp" alt="Banner Image" class="w-full h-full object-cover" />
    </div>

    <div class="relative -mt-40 m-4">
        <form class="bg-white max-w-xl w-full mx-auto shadow-[0_2px_10px_-3px_rgba(6,81,237,0.3)] p-6 sm:p-8 rounded-2xl" action="register" method="POST">
            <div class="mb-12">
                <h3 class="text-gray-800 text-3xl text-center">Créer un compte</h3>
            </div>

            <!-- Nom -->
            <div class="mt-8">
                <label class="text-gray-800 text-xs block mb-2">Nom</label>
                <div class="relative flex items-center">
                    <input name="nom" type="text" required class="w-full bg-transparent text-sm text-gray-800 border-b border-gray-300 focus:border-blue-500 pl-2 pr-8 py-3 outline-none" placeholder="Entrez votre nom" />
                </div>
            </div>

            <!-- Prénom -->
            <div class="mt-8">
                <label class="text-gray-800 text-xs block mb-2">Prénom</label>
                <div class="relative flex items-center">
                    <input name="prenom" type="text" required class="w-full bg-transparent text-sm text-gray-800 border-b border-gray-300 focus:border-blue-500 pl-2 pr-8 py-3 outline-none" placeholder="Entrez votre prénom" />
                </div>
            </div>

            <div class="mt-8">
                <label class="text-gray-800 text-xs block mb-2">Email</label>
                <div class="relative flex items-center">
                    <input name="email" type="email" required class="w-full bg-transparent text-sm text-gray-800 border-b border-gray-300 focus:border-blue-500 pl-2 pr-8 py-3 outline-none" placeholder="Entrez votre email" />
                </div>
            </div>

            <div class="mt-8">
                <label class="text-gray-800 text-xs block mb-2">Mot de passe</label>
                <div class="relative flex items-center">
                    <input name="password" type="password" required class="w-full bg-transparent text-sm text-gray-800 border-b border-gray-300 focus:border-blue-500 pl-2 pr-8 py-3 outline-none" placeholder="Entrez votre mot de passe" />
                </div>
            </div>

            <div class="flex items-center mt-8">
                <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 shrink-0 rounded" />

            </div>

            <div class="mt-8">
                <button type="submit" class="w-full shadow-xl py-2.5 px-4 text-sm font-semibold tracking-wider rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none transition-all">
                    S'inscrire
                </button>
                <p class="text-gray-800 text-sm mt-4 text-center">Vous avez déjà un compte? <a href="login.jsp" class="text-blue-500 font-semibold hover:underline ml-1">Connectez-vous ici</a></p>
            </div>
        </form>
    </div>
</main>

<!-- Script pour afficher le message toastr après l'enregistrement réussi -->
<script>
    // Vérifier si l'utilisateur a été enregistré avec succès, ici vous pouvez ajouter une variable ou une condition selon votre logique
    // Exemple simple de condition (vous devez ajuster selon la logique de votre back-end)
    const userRegistered = true; // À remplacer par la condition réelle

    if (userRegistered) {
        toastr.success('Votre inscription a été réussie !', 'Succès', {
            positionClass: 'toast-top-center',
            timeOut: 5000, // La notification disparaît après 5 secondes
        });
    }
</script>

</body>
</html>
