import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../api/my_api.dart';
import '../models/article.dart';

class PagePayer extends StatefulWidget {
  @override
  _PagePayerState createState() => _PagePayerState();
}

class _PagePayerState extends State<PagePayer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payer'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('paniers')
                .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return FutureBuilder(
                  future: MyAPI.getArticlesWithFavorisAndCommandeOfCurrentUser(
                      afficherSeulementFavoris: false,
                      afficherSeulementEstCommande: true
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Article>? articles = snapshot.data;

                      if (articles!.isEmpty) {
                        return const Center(
                          child: Text(
                              'Vous n\'avez aucun articles dans votre panier'),
                        );
                      }

                      return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Articles achetés :',
                                style: TextStyle(fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: articles.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(articles[index].title),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(articles[index].getPriceString()),
                                          IconButton(
                                            icon: Icon(
                                              size: 20,
                                              articles[index].getEstCommande() ? Icons.remove_shopping_cart_outlined : Icons.add_shopping_cart,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                articles[index].changerEstCommande();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Prix total : ${articles.fold(0.0, (previousArticle, article) => previousArticle + article.price).toStringAsFixed(2)} €',
                                style: const TextStyle(fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16.0),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    TextFormField(
                                        controller: _cardController,
                                        decoration: const InputDecoration(labelText: "Votre carte bancaire"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(16), // limiter à 16 chiffres
                                          // ou utiliser `MaskTextInputFormatter` pour formater le numéro avec des espaces
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Veuillez entrer votre carte bancaire";
                                          } else if (value.length < 16) {
                                            return 'Le numéro de carte doit comporter 16 chiffres';
                                          }
                                        }
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          MyAPI.fairePayerPanierNonPayeOfCurrentUser();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Payer'),
                                    ),
                                  ]
                                )
                              ),
                            ],
                          ),
                        );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
            }
        )
    );
  }
}
