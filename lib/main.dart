import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'ui/my_theme.dart';
import 'ui/page_connexion.dart';
import 'view_models/setting_view_model.dart';
import 'view_models/task_view_model.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyShop());
}
class MyShop extends StatelessWidget{
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
          /* ChangeNotifierProvider(
            create:(_){
              TaskViewModel taskViewModel = TaskViewModel();
              taskViewModel.generateTasks();
              return taskViewModel;
            } 
          ) */
        ],
      child: Consumer<SettingViewModel>(
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark():MyTheme.light(),
              title: 'My Shop',
              home: PageConnexion()
          );
        },
      ),
    ); 
  }
}

