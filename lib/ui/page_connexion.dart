import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'introductionPage.dart';
import 'page_inscription.dart';

class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  _PageConnexionState createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresse email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Se connecter'),
                onPressed: () async {
                  String messageErreur = 'Erreur inconnue'; // déclaration et initialisation de la variable messageErreur
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const IntroductionPage()),
                    );
                  } on FirebaseAuthException catch (e) {
                    String messageErreur = '';

                    if (e.message!.contains('invalid-email')) {
                      messageErreur = 'L\'adresse email est invalide';
                    } else if (e.message!.contains('user-not-found')) {
                      messageErreur = 'Votre compte n\'existe pas, veuillez vous inscrire !';
                    } else if (e.message!.contains('wrong-password')) {
                      messageErreur = 'Le mot de passe est incorrect';
                    } else {
                      messageErreur = e.message!;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erreur lors de la connexion'),
                          content: Text(messageErreur), // utilisation de la variable messageErreur
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                child: const Text('Pas encore inscrit ?'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageInscription()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
