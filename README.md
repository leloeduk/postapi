Résumé des opérations HTTP
Méthode Endpoint (exemple) Rôle
GET /posts Récupérer la liste
POST /posts Créer un nouveau post
PUT /posts/{id} Modifier un post
DELETE /posts/{id} Supprimer un post
Cet exemple est volontairement simple (pas de Clean Architecture complète ni de gestion d’erreurs poussée) pour bien comprendre le mécanisme CRUD, Dio et BLoC sur deux pages. Vous pouvez facilement l’étendre.
