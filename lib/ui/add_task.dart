import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../view_models/task_view_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),

      body: Center(
        child: Column(
          children: [
            const FormulaireAddTask(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                backgroundColor: Colors.lightBlue,
              ),
              onPressed: () {
                context.read<TaskViewModel>().addTask(Task.newTask());
                Navigator.pop(context);
              },
              child: const Text("Add Task"),
            ),
          ],
        )
      ),
    );
  }
}

class FormulaireAddTask extends StatefulWidget{
  const FormulaireAddTask ({super.key});

  @override
  State<FormulaireAddTask> createState() => _FormulaireAddTaskState();
}

class _FormulaireAddTaskState extends State<FormulaireAddTask>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Nom"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom de tache';
              }
              return null;
            }
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: "Tag"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un tag pour la tache';
                }
                return null;
              }
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: "Heures"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              initialValue: "0",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer un nombre d'heures";
                }
                return null;
              }
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: "Difficulté"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une difficulté';
                }
                return null;
              }
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              }
          ),
        ]
    ),
    );
  }
}
