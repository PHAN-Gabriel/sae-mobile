import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../api/my_api.dart';
import '../models/article.dart';

class PageHistorique extends StatefulWidget {
  @override
  _PageHistoriqueState createState() => _PageHistoriqueState();
}

class _PageHistoriqueState extends State<PageHistorique> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('paniers')
              .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .where('estPaye', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FutureBuilder(
                future: MyAPI.getHistoriqueOfCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<List<Article>>? articles = snapshot.data;

                    if (articles!.isEmpty) {
                      return const Center(
                        child: Text('Vous n\'avez jamais payé un panier !'),
                      );
                    }

                    return ListView.builder(
                      itemCount: articles!.length,
                      itemBuilder: (BuildContext context, int index) {
                        double prixTotal = articles[index].fold(0, (previousValue, element) => previousValue + element.price);
                        return Card(
                            elevation: 2, // Ajouter l'élévation ici
                            child:  ListTile(
                              title: Text('Panier ${index + 1} : ${prixTotal.toStringAsFixed(2)}€'),
                            )
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
      );
  }
}
