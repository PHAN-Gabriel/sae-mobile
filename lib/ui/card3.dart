
import 'package:flutter/material.dart';
import '../api/my_api.dart';

import '../models/todo.dart';

class Ecran3 extends StatefulWidget{
  @override
  State<Ecran3> createState() => _Ecran3State();
}

class _Ecran3State extends State<Ecran3> {
  late Future<List<Todo>> futureTodo;
  MyAPI myAPI =MyAPI();

  @override
  void initState(){
    super.initState();
    futureTodo = myAPI.getTodos();
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
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.lightBlue,child: Text(snapshot.data?[index].id.toString()??'0'),),
                      title: Text(snapshot.data?[index].title??""),
                      trailing: Checkbox(value: snapshot.data?[index].completed, onChanged: (bool? value) {  },),
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