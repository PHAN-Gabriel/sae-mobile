
import 'package:flutter/material.dart';
import '../api/my_api.dart';

import '../models/article.dart';
import '../models/todo.dart';

class Ecran3 extends StatefulWidget{
  @override
  State<Ecran3> createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  late Future<List<Article>> futureTodo;
  MyAPI myAPI =MyAPI();

  @override
  void initState(){
    super.initState();
    futureTodo = myAPI.getArticles();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureTodo,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(snapshot.data?[index].image??""),
                      title: Text(snapshot.data?[index].title??""),
                    ),
                  );
                });
          }
          else if (snapshot.hasError){
            return Text('${snapshot.error}');
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        });
  }
}