import 'package:flutter/material.dart';

import 'models/task.dart';

class Detail extends StatelessWidget{
  final Task task;
  
  const Detail({required this.task});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${task.title} detail'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('id: ${task.id}'),
              Text('title: ${task.title}'),
              Text('description: ${task.description}'),
              Text('tags: ${task.tags.join(" ")}'),
              Text('difficulty: ${task.difficulty}'),
              Text('nb hours: ${task.nbhours}')
            ],
          ),
        ),
      ),
    );
  }
  
}
