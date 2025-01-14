<%@ page import="org.servlet.livre_dor.models.AppreciationDAO" %>
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page import="java.util.List" %>
<%@ page import="org.servlet.livre_dor.models.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livre d'Or - Appréciations</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            background-color: #ffffff;
        }
        .navbar-brand {
            font-weight: 600;
            color: #2c3e50 !important;
        }
        .user-profile {
            display: flex;
            align-items: center;
            padding: 0.5rem 1rem;
            background-color: #f8f9fa;
            border-radius: 50px;
            margin-right: 1rem;
        }
        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 10px;
        }
        .user-name {
            color: #2c3e50;
            margin-right: 15px;
        }
        .appreciation-card {
            transition: transform 0.2s;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,.05);
            width: 300px;
            flex: 0 0 300px;
            margin-right: 1rem;
            height: 250px;
        }
        .appreciation-card:hover {
            transform: translateY(-5px);
        }
        .card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 2px 15px rgba(0,0,0,.05);
        }
        .btn-custom-primary {
            background-color: #3498db;
            border-color: #3498db;
            padding: 0.5rem 1.5rem;
            border-radius: 50px;
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .modal-content {
            border-radius: 15px;
            border: none;
        }
        .scrolling-wrapper {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            padding: 1rem 0;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: thin;
            scrollbar-color: #3498db #f8f9fa;
        }
        .scrolling-wrapper::-webkit-scrollbar {
            height: 8px;
        }
        .scrolling-wrapper::-webkit-scrollbar-track {
            background: #f8f9fa;
            border-radius: 4px;
        }
        .scrolling-wrapper::-webkit-scrollbar-thumb {
            background-color: #3498db;
            border-radius: 4px;
        }
        .section-title {
            position: relative;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: #3498db;
            border-radius: 2px;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .card-text {
            flex-grow: 1;
            overflow: auto;
        }
    </style>
</head>
<body class="bg-light">

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-book-open mr-2"></i>
            Livre d'Or
        </a>

        <div class="ml-auto d-flex align-items-center">
            <%
                String userName = "";
                String userInitial = "";
                if (session != null && session.getAttribute("userId") != null) {
                    User currentUser = (User) session.getAttribute("user");
                    if (currentUser != null) {
                        userName = currentUser.getPrenom() + " " + currentUser.getNom();
                        userInitial = String.valueOf(currentUser.getPrenom().charAt(0)).toUpperCase();
                    }
            %>
            <div class="user-profile">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <span class="user-name"><%= userName %></span>
                <form action="logout" method="post" class="m-0">
                    <button type="submit" class="btn btn-sm btn-outline-secondary rounded-pill">
                        <i class="fas fa-sign-out-alt mr-1"></i>
                        Déconnexion
                    </button>
                </form>
            </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container" style="margin-top: 100px;">
    <!-- Affichage du message d'alerte -->
    <%
        String alertMessage = (String) request.getAttribute("alertMessage");
        if (alertMessage != null) {
    %>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <%= alertMessage %>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <%
        }
    %>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Livre d'Or</h2>
        <button class="btn btn-custom-primary" data-toggle="modal" data-target="#addAppreciationModal">
            <i class="fas fa-plus-circle mr-2"></i>
            Nouvelle Appréciation
        </button>
    </div>

    <%
        int authenticatedUserId = (session != null && session.getAttribute("userId") != null)
                ? (int) session.getAttribute("userId")
                : -1;

        AppreciationDAO dao = new AppreciationDAO();
        List<Appreciation> allAppreciations = dao.getAllAppreciations();
        List<Appreciation> userAppreciations = new ArrayList<>();
        List<Appreciation> otherAppreciations = new ArrayList<>();

        if (allAppreciations != null) {
            for (Appreciation appreciation : allAppreciations) {
                if (appreciation.getUser().getId() == authenticatedUserId) {
                    userAppreciations.add(appreciation);
                } else {
                    otherAppreciations.add(appreciation);
                }
            }
        }
    %>

    <!-- Section des appréciations de l'utilisateur -->
    <section class="mb-5">
        <h3 class="section-title">Vos Appréciations</h3>
        <div class="scrolling-wrapper">
            <% if (!userAppreciations.isEmpty()) {
                for (Appreciation appreciation : userAppreciations) {
                    User user = appreciation.getUser();
            %>
            <div class="appreciation-card">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex align-items-center mb-3">
                        <div class="user-avatar mr-2">
                            <%= String.valueOf(user.getPrenom().charAt(0)).toUpperCase() %>
                        </div>
                        <div>
                            <h6 class="mb-0"><%= user.getPrenom() %> <%= user.getNom() %></h6>
                            <small class="text-muted"><%= appreciation.getDate() %></small>
                        </div>
                    </div>
                    <p class="card-text"><%= appreciation.getAppreciation() %></p>
                    <div class="mt-auto">
                        <form action="deleteAppreciation" method="post" style="display: inline;" onsubmit="return confirmDeletion();">
                            <input type="hidden" name="id" value="<%= appreciation.getId() %>">
                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill">
                                <i class="fas fa-trash-alt mr-1"></i>
                                Supprimer
                            </button>
                        </form>
                        <button class="btn btn-sm btn-outline-warning rounded-pill ml-2" data-toggle="modal"
                                data-target="#editAppreciationModal<%= appreciation.getId() %>">
                            <i class="fas fa-edit mr-1"></i>
                            Modifier
                        </button>
                    </div>
                </div>
            </div>
            <% }
            } else { %>
            <div class="w-100">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle mr-2"></i>
                    Vous n'avez pas encore publié d'appréciation.
                </div>
            </div>
            <% } %>
        </div>
    </section>

    <!-- Section des appréciations publiées -->
    <section>
        <h3 class="section-title">Appréciations Publiées</h3>
        <div class="scrolling-wrapper">
            <% if (!otherAppreciations.isEmpty()) {
                for (Appreciation appreciation : otherAppreciations) {
                    User user = appreciation.getUser();
            %>
            <div class="appreciation-card">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex align-items-center mb-3">
                        <div class="user-avatar mr-2">
                            <%= String.valueOf(user.getPrenom().charAt(0)).toUpperCase() %>
                        </div>
                        <div>
                            <h6 class="mb-0"><%= user.getPrenom() %> <%= user.getNom() %></h6>
                            <small class="text-muted"><%= appreciation.getDate() %></small>
                        </div>
                    </div>
                    <p class="card-text"><%= appreciation.getAppreciation() %></p>
                </div>
            </div>
            <% }
            } else { %>
            <div class="w-100">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle mr-2"></i>
                    Aucune appréciation publiée pour le moment.
                </div>
            </div>
            <% } %>
        </div>
    </section>
</div>

<!-- Modals de modification -->
<% for (Appreciation appreciation : userAppreciations) { %>
<div class="modal fade" id="editAppreciationModal<%= appreciation.getId() %>" tabindex="-1" role="dialog"
     aria-labelledby="editAppreciationModalLabel<%= appreciation.getId() %>" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="editAppreciation">
                <div class="modal-header border-0">
                    <h5 class="modal-title" id="editAppreciationModalLabel<%= appreciation.getId() %>">
                        Modifier votre appréciation
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" value="<%= appreciation.getId() %>">
                    <div class="form-group">
                        <textarea class="form-control" id="appreciation<%= appreciation.getId() %>"
                                  name="appreciation" rows="4" required><%= appreciation.getAppreciation().trim() %></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light rounded-pill" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-custom-primary">Sauvegarder</button>
                </div>
            </form>
        </div>
    </div>
</div>
<% } %>

<!-- Modal d'ajout -->
<div class="modal fade" id="addAppreciationModal" tabindex="-1" role="dialog" aria-labelledby="addAppreciationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="addAppreciation">
                <div class="modal-header border-0">
                    <h5 class="modal-title" id="addAppreciationModalLabel">
                        <i class="fas fa-pen-fancy mr-2"></i>
                        Nouvelle Appréciation
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="newAppreciation">Votre message</label>
                        <textarea class="form-control" id="newAppreciation" name="appreciation"
                                  rows="4" required placeholder="Partagez votre expérience..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light rounded-pill" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-custom-primary">Publier</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function confirmDeletion() {
        return window.confirm("Êtes-vous sûr de vouloir supprimer cette appréciation ?");
    }
</script>

</body>
</html>