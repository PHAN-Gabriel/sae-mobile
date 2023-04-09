
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../api/my_api.dart';

import 'detail.dart';
import '../models/article.dart';

class EcranArticles extends StatefulWidget{
  @override
  State<EcranArticles> createState() => _EcranArticlesState();
}

class _EcranArticlesState extends State<EcranArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('articles')
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
                      afficherSeulementEstCommande: false
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Article>? articles = snapshot.data;

                      if (articles!.isEmpty) {
                        return const Center(
                          child: Text('Vous n\'avez aucun articles dans votre panier'),
                        );
                      }

                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // nombre de colonnes
                        ),
                        itemCount: articles?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Detail(article: articles[index]),
                              ));
                            },
                            child: Card(
                              elevation: 6,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      articles[index].image ?? "",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      articles[index].title ?? "",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row (
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${articles[index].price.toString()} €" ?? "",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          articles[index].getEstEnFavori() ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            articles[index].changerEstEnFavori();
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
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