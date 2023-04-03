import 'dart:convert';

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
    final response = await http.get(Uri.parse('http://fakestoreapi.com/products'));
    if (response.statusCode == 200){
      debugPrint("200");
      final List<dynamic> json = jsonDecode(response.body);
      debugPrint("apres jsonDecode");
      final articles = <Article>[];
      json.forEach((element) {
        articles.add(Article.fromJson(element));
      });
      debugPrint("avant return");
      return articles;
    }else{
      debugPrint("pb connection");
      throw Exception('Failed to load articles');
    }
  }
}