import 'package:flutter/material.dart';

import '../models/article.dart';

class Detail extends StatefulWidget{
  final Article article;

  const Detail({ required this.article });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${widget.article.title} detail'),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(widget.article.title,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
                ),
                Image.network(
                  widget.article.image,
                  fit: BoxFit.cover,
                  width: 200,
                ),
                Text(widget.article.getPriceString(),
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
                ),
                Text(widget.article.description),
                IconButton(
                  icon: Icon(
                    size: 50,
                    widget.article.getEstCommande() ? Icons.remove_shopping_cart_outlined : Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.article.changerEstCommande();
                    });
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
