
import 'package:flutter/material.dart';
import 'package:td2_2223/ui/page_connexion.dart';
import 'package:td2_2223/ui/page_payer.dart';

import '../api/my_api.dart';
import '../models/article.dart';
import 'add_article.dart';
import 'ecran_panier.dart';
import 'ecran_favoris.dart';
import 'settings.dart';
import 'ecran_articles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    EcranArticles(),
    EcranFavoris(),
    EcranPanier(),
    EcranSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageConnexion()),
              );
            },
        ),
        title: Text('Le p\'tit phanashop', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Les articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Vos favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Votre panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    if (_selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddArticle()));
        },
        child: const Icon(Icons.add),
      );
    } else if (_selectedIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PagePayer()));
        },
        child: const Icon(Icons.shopping_cart_outlined),
      );
    }
    return const SizedBox.shrink();
  }
}

