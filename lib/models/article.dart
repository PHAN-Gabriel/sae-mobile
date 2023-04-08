import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Article {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  bool _estEnFavori = false;
  bool _estCommande = false;

  Article(
      {required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image});

  factory Article.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];

    if (json['tags'] != null) {
      json['tags'].forEach((t) {
        tags.add(t);
      });
    }

    return Article(
        id: json['id'] ?? -1,
        title: json['title'] ?? 'inconnu',
        price: json['price'] ?? -1,
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? ''
    );
  }

  bool getEstEnFavori() {
    return _estEnFavori;
  }

  void changerEstEnFavori() {
    _estEnFavori = !_estEnFavori;

    _estEnFavori ? ajouterDansFavoris() : retirerDesFavoris();
  }

  void ajouterDansFavoris() {
    FirebaseFirestore.instance.collection("favoris").add({
      "idArticle": id,
      "idUser": FirebaseAuth.instance.currentUser?.uid
    });
  }

  void retirerDesFavoris() {
    FirebaseFirestore.instance
        .collection('favoris')
        .where('idArticle', isEqualTo: id)
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  bool getEstCommande() {
    return _estCommande;
  }

  void changerEstCommande() {
    _estCommande = !_estCommande;

    if (_estCommande) {
      ajouterDansPanierNonPaye();
    } else {
      retirerDuPanierNonPaye();
    }
  }

  Future<void> ajouterDansPanierNonPaye() async {
    // On récupére s'il un panier non payé de l'utilisateur pour vérifier s'il existe déjà
    final QuerySnapshot<Map<String, dynamic>> panierQuery = await getPanierNonPaye();

    final DocumentReference<Map<String, dynamic>> panier;
    if (panierQuery.docs.isEmpty) {
      // On crée un nouveau panier si aucun panier non payé n'existe pour l'utilisateur
      panier = FirebaseFirestore.instance.collection('paniers').doc();
      await panier.set({
        'idUser': FirebaseAuth.instance.currentUser?.uid,
        'estPaye': false,
        'idArticles': [id],
      });
    } else {
      // Ajouter l'article au panier existant
      panier = panierQuery.docs.first.reference;
      await panier.update({
        'idArticles': FieldValue.arrayUnion([id]),
      });
    }
  }

  Future<void> retirerDuPanierNonPaye() async {
    // On récupère le panier non payé de l'utilisateur
    final QuerySnapshot<Map<String, dynamic>> panierQuery = await getPanierNonPaye();

    if (panierQuery.docs.isNotEmpty) {
      final DocumentReference<Map<String, dynamic>> panier = panierQuery.docs.first.reference;
      await panier.update({
        'idArticles': FieldValue.arrayRemove([id]),
      });
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPanierNonPaye() {
    return FirebaseFirestore.instance
        .collection('paniers')
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('estPaye', isEqualTo: false)
        .get();
  }
}

