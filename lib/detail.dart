import 'package:flutter/material.dart';

import 'models/article.dart';
import 'models/task.dart';

class Detail extends StatelessWidget{
  final Article article;
  
  const Detail({required this.article});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${article.title} detail'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(article.title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
              ),
              Image.network(
                article.image,
                fit: BoxFit.cover,
                width: 200,
              ),
              Text("${article.price} €",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
              ),
              Text(article.description),
            ],
          ),
        ),
      ),
    );
  }
  
}
