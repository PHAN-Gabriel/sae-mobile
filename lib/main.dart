import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/my_theme.dart';
import 'view_models/setting_view_model.dart';
import 'ui/home.dart';
import 'view_models/task_view_model.dart';

void main() {
  runApp(MyTD3());
}
class MyTD3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider( 
        providers: [
          ChangeNotifierProvider(
            create: (_){
              SettingViewModel settingViewModel = SettingViewModel();
              //getSettings est deja appelee dans le constructeur
              return settingViewModel;
            },
          ),
          ChangeNotifierProvider(
            create:(_){
              TaskViewModel taskViewModel = TaskViewModel();
              taskViewModel.generateTasks();
              return taskViewModel;
            } 
          )
        ],
      child: Consumer<SettingViewModel>( //Consumer dans Flutter permet de s'abonner au changement de la VueModele
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark():MyTheme.light(),
              title: 'TD2',
              home: Home()
          );
        },
      ),
    ); 
  }
}

