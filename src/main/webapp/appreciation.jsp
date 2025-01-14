<%@ page import="org.servlet.livre_dor.models.AppreciationDAO" %>
<%@ page import="org.servlet.livre_dor.models.Appreciation" %>
<%@ page import="java.util.List" %>
<%@ page import="org.servlet.livre_dor.models.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Appréciations</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container">
    <h1 class="my-4">Appréciations des Utilisateurs</h1>

    <!-- Affichage du message d'alerte après suppression -->
    <%
        String alertMessage = (String) request.getAttribute("alertMessage");
        if (alertMessage != null) {
    %>
    <div class="alert alert-info">
        <%= alertMessage %>
    </div>
    <%
        }
    %>

    <!-- Bouton de Déconnexion -->
    <form action="logout" method="post">
        <button type="submit" class="btn btn-danger mb-4">Déconnexion</button>
    </form>

    <button class="btn btn-primary mb-4" data-toggle="modal" data-target="#addAppreciationModal">
        Ajouter une Appréciation
    </button>

    <div class="row">
        <%
            // Utilisation de la variable session implicite
            int authenticatedUserId = (session != null && session.getAttribute("userId") != null)
                    ? (int) session.getAttribute("userId")
                    : -1;

            // Récupérer toutes les appréciations
            AppreciationDAO dao = new AppreciationDAO();
            List<Appreciation> appreciations = dao.getAllAppreciations();

            if (appreciations != null && !appreciations.isEmpty()) {
                for (Appreciation appreciation : appreciations) {
                    User user = appreciation.getUser();
        %>
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">
                        <strong>Utilisateur :</strong>
                        <%= user.getNom() %>
                        <%= user.getPrenom() %>
                    </h5>
                    <p class="card-text"><%= appreciation.getAppreciation() %></p>
                    <footer class="blockquote-footer"><%= appreciation.getDate() %></footer>

                    <%
                        if (user.getId() == authenticatedUserId) {
                    %>
                    <!-- Boutons Modifier et Supprimer -->
                    <div class="mt-3">
                        <form action="deleteAppreciation" method="post" style="display: inline;" onsubmit="return confirmDeletion();">
                            <input type="hidden" name="id" value="<%= appreciation.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Supprimer</button>
                        </form>
                        <button class="btn btn-warning btn-sm" data-toggle="modal"
                                data-target="#editAppreciationModal<%= appreciation.getId() %>">
                            Modifier
                        </button>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <script>
            function confirmDeletion() {
                return window.confirm("Êtes-vous sûr de vouloir supprimer cette appréciation ?");
            }
        </script>

        <!-- Modal de modification -->
        <div class="modal fade" id="editAppreciationModal<%= appreciation.getId() %>" tabindex="-1" role="dialog"
             aria-labelledby="editAppreciationModalLabel<%= appreciation.getId() %>" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="editAppreciation">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editAppreciationModalLabel<%= appreciation.getId() %>">
                                Modifier Appréciation
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" value="<%= appreciation.getId() %>">
                            <div class="form-group">
                                <label for="appreciation<%= appreciation.getId() %>">Appréciation</label>
                                <textarea class="form-control" id="appreciation<%= appreciation.getId() %>" name="appreciation" rows="4" required><%= appreciation.getAppreciation().trim() %></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                            <button type="submit" class="btn btn-primary">Sauvegarder</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12">
            <p>Aucune appréciation disponible pour le moment.</p>
        </div>
        <%
            }
        %>

    </div>
</div>

<!-- Modal d'ajout -->
<div class="modal fade" id="addAppreciationModal" tabindex="-1" role="dialog" aria-labelledby="addAppreciationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="post" action="addAppreciation">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAppreciationModalLabel">Nouvelle Appréciation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="newAppreciation">Votre Appréciation</label>
                        <textarea class="form-control" id="newAppreciation" name="appreciation" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
