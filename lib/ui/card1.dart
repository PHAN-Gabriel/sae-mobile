
import 'package:flutter/material.dart';
import '../api/my_api.dart';

import '../models/article.dart';
import '../models/todo.dart';

class Ecran1 extends StatefulWidget{
  @override
  State<Ecran1> createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
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
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // nombre de colonnes
                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            snapshot.data?[index].image ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data?[index].title ?? "",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${snapshot.data?[index].price.toString()} €" ?? "",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
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