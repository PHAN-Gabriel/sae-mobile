import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td2_2223/ui/home.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildPage('Le petit Phanashop', 'Votre application de shopping en ligne', Icons.shop),
          _buildPage('Simple', 'Choisissez votre produit, visualiser sa description', Icons.accessibility),
          _buildPage('Rapide', 'Et commander directement en ligne !', Icons.access_alarm),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPage(String title, String description, IconData icon) {
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            child: const Text('Passer'),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          TextButton(
            child: const Text('Suivant'),
            onPressed: () {
              if (_pageController.page == 2) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              } else {
                _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              }
            },
          ),
        ],
      ),
    );
  }
}