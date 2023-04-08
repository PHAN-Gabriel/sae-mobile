import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController(initialPage: 0);
  List<Introduction> affichage = [
    Introduction(titre: 'Le petit Phanashop', texte: 'Votre application de shopping en ligne', icone: Icons.shop),
    Introduction(titre: 'Simple', texte: 'Choisissez votre produit, visualiser sa description', icone: Icons.accessibility),
    Introduction(titre: 'Rapide', texte: 'Et commander directement en ligne !', icone: Icons.access_alarm)
  ];
  bool _skipIntroduction = false;

  @override
  void initState() {
    super.initState();
    _verifierEtFaireSkipIntroduction();
  }

  void _verifierEtFaireSkipIntroduction() async {
    final prefs = await SharedPreferences.getInstance();

    _skipIntroduction = prefs.getBool('skipIntroduction') ?? false;

    if (_skipIntroduction) {
      gotoPageAccueil();
    }
  }

  void _sauvegarderEtatSkipIntruction(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipIntroduction', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _getPages()
      ),
      bottomNavigationBar: _genererNavigationBar(),
    );
  }

  List<Widget> _getPages() {
    List<Widget> pages = [];

    for (int i = 0; i < affichage.length; i++) {
      pages.add(_genererPage(
        affichage[i].titre,
        affichage[i].texte,
        affichage[i].icone,
      ));
    }

    return pages;
  }

  Widget _genererPage(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(description, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _genererNavigationBar() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _skipIntroduction,
                    onChanged: (value) {
                      setState(() {
                        _skipIntroduction = value!;
                        _sauvegarderEtatSkipIntruction(value);
                      });
                    },
                  ),
                  const Text('Ne plus afficher cette page la prochaine fois'),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    child: const Text('Passer'),
                    onPressed: () {
                      gotoPageAccueil();
                    },
                  ),
                  TextButton(
                    child: const Text('Suivant'),
                    onPressed: () {
                      if (_pageController.page == 2) {
                        gotoPageAccueil();
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


  void gotoPageAccueil() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  }
}

class Introduction {
  String titre;
  String texte;
  IconData icone;

  Introduction({required this.titre, required this.texte, required this.icone});
}
