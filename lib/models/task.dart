import 'package:flutter/foundation.dart';

class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;
  static int nb = 1;

  Task(
      {required this.id,
      required this.title,
      required this.tags,
      required this.nbhours,
      required this.difficulty,
      required this.description});

  // Factory in Flutter is used to create a constructor that returns an instance of the class it’s implemented in.
  factory Task.newTask() {
    //print to see the value of nb
    debugPrint('nb = $nb');
    nb++;
    return Task(
        id: nb,
        title: 'title $nb',
        tags: ['tags $nb'],
        nbhours: nb,
        difficulty: nb % 5,
        description: 'description $nb');
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];

    if (json['tags'] != null) {
      json['tags'].forEach((t) {
        tags.add(t);
      });
    }

    return Task(
        id: json['id'] ?? -1,
        title: json['title'] ?? 'unconnu',
        tags: tags,
        nbhours: json['nbhours'] ?? -1,
        difficulty: json['difficulty'] ?? -1,
        description: json['description'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    final tags = <String>[];
    this.tags.forEach((element) {
      tags.add(element);
    });

    data['id'] = this.id;
    data['title'] = this.title;
    data['tags'] = tags;
    data['nbhours'] = this.nbhours;
    data['difficulty'] = this.difficulty;
    data['description'] = this.description;
    return data;
  }

  static List<Task> generateTask(int i) {
    /*List<Task> tasks=[];
    for(int n=0;n<i;n++){
      tasks.add(Task(id: n, title: "title $n", tags: ['tag $n','tag ${n+1}'], nbhours: n, difficulty: n, description: '$n'));
    }
    return tasks;*/
    nb = 49;
    return List.generate(
      nb + 1,
      (index) => Task(
          id: index,
          title: 'title $index',
          tags: ['tag $index', 'tag ${index + 1}'],
          nbhours: index,
          difficulty: index,
          description: 'description task $index'),
    );
  }
}
