import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:td2_2223/ui/page_connexion.dart';

import 'introductionPage.dart';

class PageInscription extends StatefulWidget {
  const PageInscription({super.key});

  @override
  _PageInscriptionState createState() => _PageInscriptionState();
}

class _PageInscriptionState extends State<PageInscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresse email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  } else if (value.length < 8) {
                    return 'Le mot de passe doit contenir au moins 8 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('S\'inscrire'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                      } else if (e.message!.contains('weak-password')) {
                        messageErreur = 'Le mot de passe est trop faible';
                      } else if (e.message!.contains('email-already-in-use')) {
                        messageErreur = 'Cette adresse email est déjà utilisée';
                      } else {
                        messageErreur = e.message!;
                      }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erreur lors de l\'inscription'),
                            content: Text(messageErreur),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                child: const Text('Déjà connecté ?'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageConnexion()),
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
