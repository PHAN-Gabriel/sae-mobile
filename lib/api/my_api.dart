import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../models/article.dart';

import '../models/task.dart';

class MyAPI{
  // A utiliser pour initaliser les données
  static void ajouterArticlesDansFireBase(List<Article> articles) {
    for(Article article in articles) {
      FirebaseFirestore.instance.collection("articles").add({
        "id": article.id,
        "title": article.title,
        "category": article.category,
        "description": article.description,
        "price": article.price,
        "image": article.image
      });
    }
  }

  static Future<List<Article>> getArticlesWithFavorisAndCommandeOfCurrentUser({required bool afficherSeulementFavoris, required bool afficherSeulementEstCommande}) async{
    List<Article> articles = [];
    List<int> idArticlesFavoris = [];
    List<int> idArticlesCommandes = [];

    // On récupère les id des articles commandés
    QuerySnapshot<Map<String, dynamic>> paniersQuery = await getArticlesDuPanierNonPayeOfCurrentUser();

    if (paniersQuery.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await paniersQuery.docs.first.reference.get();
      idArticlesCommandes.addAll(List<int>.from(docSnapshot.data()!['idArticles']));
    }

    // On récupère les id des articles favoris
    QuerySnapshot<Map<String, dynamic>> favorisQuery = await getFavorisOfCurrentUser();

    if (favorisQuery.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await favorisQuery.docs.first.reference.get();
      idArticlesFavoris.addAll(List<int>.from(docSnapshot.data()!['idArticles']));
    }

    // On génère la liste des articles (en prenant compte des favoris et commandés)
    await FirebaseFirestore.instance
        .collection("articles")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        Map<String, dynamic> json = document.data();
        json.addAll({'favori': idArticlesFavoris.contains(document.data()['id']) });
        json.addAll({'commande': idArticlesCommandes.contains(document.data()['id']) });
        Article article = Article.fromJson(json);
        articles.add(article);
      });
    });

    return articles.where((article) => !(afficherSeulementEstCommande || afficherSeulementFavoris) || (afficherSeulementFavoris && article.getEstEnFavori()) || (afficherSeulementEstCommande && article.getEstCommande())).toList();
  }

  static Future<void> ajouterDansFavorisOfCurrentUser(Article article) async {
    // On récupère, s'il y en a, les articles favoris de l'utilisateur pour vérifier s'il existe déjà
    final QuerySnapshot<Map<String, dynamic>> favorisQuery = await getFavorisOfCurrentUser();

    final DocumentReference<Map<String, dynamic>> favoris;
    if (favorisQuery.docs.isEmpty) {
      // On crée un nouveau favoris de l'utilisateur car il y'en a pas
      favoris = FirebaseFirestore.instance.collection('favoris').doc();
      await favoris.set({
        'idUser': FirebaseAuth.instance.currentUser?.uid,
        'idArticles': [article.id],
      });
    } else {
      // Ajouter l'article au favoris de l'utilisateur existant
      favoris = favorisQuery.docs.first.reference;
      await favoris.update({
        'idArticles': FieldValue.arrayUnion([article.id]),
      });
    }
  }

  static Future<void> retirerDesFavorisOfCurrentUser(Article article) async {
    // On récupère les articles favoris de l'utilisateur
    final QuerySnapshot<Map<String, dynamic>> favorisQuery = await getFavorisOfCurrentUser();

    if (favorisQuery.docs.isNotEmpty) {
      final DocumentReference<Map<String, dynamic>> favoris = favorisQuery.docs.first.reference;
      await favoris.update({
        'idArticles': FieldValue.arrayRemove([article.id]),
      });
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getFavorisOfCurrentUser() {
    return FirebaseFirestore.instance
        .collection('favoris')
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
  }

  static Future<void> ajouterDansPanierNonPayeOfCurrentUser(Article article) async {
    // On récupère, s'il y en a, un panier non payé de l'utilisateur pour vérifier s'il existe déjà
    final QuerySnapshot<Map<String, dynamic>> panierQuery = await getArticlesDuPanierNonPayeOfCurrentUser();

    final DocumentReference<Map<String, dynamic>> panier;
    if (panierQuery.docs.isEmpty) {
      // On crée un nouveau panier si aucun panier non payé n'existe pour l'utilisateur
      panier = FirebaseFirestore.instance.collection('paniers').doc();
      await panier.set({
        'idUser': FirebaseAuth.instance.currentUser?.uid,
        'estPaye': false,
        'idArticles': [article.id],
      });
    } else {
      // Ajouter l'article au panier existant
      panier = panierQuery.docs.first.reference;
      await panier.update({
        'idArticles': FieldValue.arrayUnion([article.id]),
      });
    }
  }

  static Future<void> retirerDuPanierNonPayeOfCurrentUser(Article article) async {
    // On récupère le panier non payé de l'utilisateur
    final QuerySnapshot<Map<String, dynamic>> panierQuery = await getArticlesDuPanierNonPayeOfCurrentUser();

    if (panierQuery.docs.isNotEmpty) {
      final DocumentReference<Map<String, dynamic>> panier = panierQuery.docs.first.reference;
      await panier.update({
        'idArticles': FieldValue.arrayRemove([article.id]),
      });
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getArticlesDuPanierNonPayeOfCurrentUser() {
    return FirebaseFirestore.instance
        .collection('paniers')
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('estPaye', isEqualTo: false)
        .get();
  }
}