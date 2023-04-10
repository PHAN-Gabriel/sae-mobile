# SAE Mobile

## Membres du groupe (2A2A)
  - PHAN Gabriel
  - PETIT Melvyn

### Fonctionnalités
  - Consultation des articles avec détails
  - Gestion et consultation des articles favoris
  - Gestion et consultation du panier (achats) + payement
  - Inscription et connexion (avec l'option "Se souvenir de moi" géré avec SharedPrefences)
  - Écran d'accueil avec l'option "Passer" ou "Suivant" accompagné d'un checkbox pour ne plus consulter cet écran pour lors des prochaines utilisations
  - Historique des achats : liste de paniers payés avec leurs articles en détail
  - Ajouter des articles (Remarquez que les images se font via URL)
  - Les données des articles avec leur favoris (par utilisateurs) et les paniers (par utilisateurs) sont stockés dans Firebase (FirebaseFirestore)
  - La gestion des utilisateurs se fait également avec Firebase (FirebaseAuth)

### Notes
  - Comme nous avons utilisé Firebase pour stocker les données, il est donc conseillé de tester l'application avec un APK (faire un Build > Flutter > Build APK) en cas de problème
