import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/my_api.dart';
import '../models/article.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({super.key});

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController(text: 'Une cabane');
  final TextEditingController _priceController = TextEditingController(text: '199.99');
  final TextEditingController _categoryController = TextEditingController(text: 'Immobilier');
  final TextEditingController _imageController = TextEditingController(text: 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71vmtaKFxLL._AC_SY355_.jpg');
  final TextEditingController _descriptionController = TextEditingController(text: 'Une cabane pour les enfants ayant moins de 12 ans');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),

      body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: "Titre"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un titre';
                        }
                        return null;
                      }
                  ),
                  TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: "Prix"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer un prix";
                        }
                      }
                  ),
                  TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(labelText: "Catégorie"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une catégorie';
                        }
                        return null;
                      }
                  ),
                  TextFormField(
                      controller: _imageController,
                      decoration: const InputDecoration(labelText: "Image (en URL)"),
                  ),
                  TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: "Description"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une description';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.button,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text("Ajouter un article"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        MyAPI.ajouterArticleDansFireBase(await Article.newArticle(
                            title: _titleController.text,
                            price: double.parse(_priceController.text),
                            description: _descriptionController.text,
                            category: _categoryController.text,
                            image: _imageController.text
                          )
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
          )
      ),
    );
  }
}