import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../models/article.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class MyAPI{

  Future<List<Task>> getTasks() async{
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("avant load");
    final dataString = await _loadAsset('assets/mydata/tasks.json');
    debugPrint("apres load");
    final Map<String,dynamic> json = jsonDecode(dataString);
    if (json['tasks']!=null){
      final tasks = <Task>[];
      json['tasks'].forEach((element){
        tasks.add(Task.fromJson(element));
      });
      return tasks;
    }else{
      return [];
    }
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  Future<List<Article>> getArticles() async{
    List<Article> articles = [];

    await FirebaseFirestore.instance
        .collection("articles")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        Article article = Article.fromJson(document.data());
        articles.add(article);
      });
    });

    return articles;
  }

  // A utiliser pour initaliser les données
  void ajouterArticlesDansFireBase(List<Article> articles) {
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
}