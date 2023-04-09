import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../api/my_api.dart';

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
    Article article = Article(
      id: json['id'] ?? -1,
      title: json['title'] ?? 'inconnu',
      price: json['price'] ?? -1,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? ''
    );

    article._estEnFavori = json['favori'] ?? false;
    article._estCommande = json['commande'] ?? false;

    return article;
  }

  bool getEstEnFavori() {
    return _estEnFavori;
  }

  void changerEstEnFavori() {
    _estEnFavori = !_estEnFavori;

    _estEnFavori ? MyAPI.ajouterDansFavorisOfCurrentUser(this) : MyAPI.retirerDesFavorisOfCurrentUser(this);
  }

  bool getEstCommande() {
    return _estCommande;
  }

  void changerEstCommande() {
    _estCommande = !_estCommande;

    _estCommande ? MyAPI.ajouterDansPanierNonPayeOfCurrentUser(this) : MyAPI.retirerDuPanierNonPayeOfCurrentUser(this);
  }
}

