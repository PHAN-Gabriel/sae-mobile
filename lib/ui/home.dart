
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../view_models/task_view_model.dart';
import 'add_task.dart';
import 'settings.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    Ecran1(),
    Ecran2(),
    Ecran3(),
    EcranSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application TD3',style: Theme.of(context).textTheme.titleLarge),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.article),
            label: 'Card1',
          ),
          BottomNavigationBarItem( icon: Icon(Icons.article),
            label: 'Card2',
          ),
          BottomNavigationBarItem( icon: Icon(Icons.article),
            label: 'Card3',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: 'Settings'),
        ], ),
        floatingActionButton: _selectedIndex==0?
          // un button qui permet d'ajouter une tache
          FloatingActionButton( // FloatingActionButton est un bouton qui flotte au dessus de l'ecran
            onPressed: (){
              // debugPrint ('Pressed');
              // // create a new task using newTask() in Task and add it to the list using addTask() in TaskViewModel
              // context.read<TaskViewModel>().addTask(Task.newTask()); 
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddTask(),
              )
              );             
            },
            child: const Icon(Icons.add),)
          :
          const SizedBox.shrink(),
    );
  }

}
