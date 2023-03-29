import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../models/todo.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class MyAPI{

  Future<List<Task>> getTasks() async{
    await Future.delayed(Duration(seconds: 1));
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

  Future<List<Todo>> getTodos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200){
      debugPrint("200");
      final List<dynamic> json = jsonDecode(response.body);
      debugPrint("apres jsonDecode");
      final todos = <Todo>[];
      json.forEach((element) {
        todos.add(Todo.fromJson(element));
      });
      debugPrint("avant return");
      return todos;
    }else{
      debugPrint("pb connection");
      throw Exception('Failed to load todos');
    }
  }
}