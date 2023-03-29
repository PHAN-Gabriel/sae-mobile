import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../detail.dart';
import '../models/task.dart';
import '../view_models/task_view_model.dart';

class Ecran1 extends StatelessWidget{
  // late permet de ne pas initialiser la variable
  late List<Task> tasks;  
  String tags='';
  @override
  Widget build(BuildContext context) {
    //watch permet de s'abonner au changement de la liste 
    tasks = context.watch<TaskViewModel>().liste; 
    
    return ListView.builder(
    itemCount: tasks.length,
    itemBuilder:(context,index)=> Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(child: Text(tasks[index].id.toString()),backgroundColor: Colors.lightBlue,),
        title: Text(tasks[index].title),
        subtitle: Text(tasks[index].tags.join(" ")),
        onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Detail(task: tasks[index]),
              )
              );
            },
      ),
    ));
  }

}
