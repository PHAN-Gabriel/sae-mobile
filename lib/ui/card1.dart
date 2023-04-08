
import 'package:flutter/material.dart';
import '../api/my_api.dart';

import 'detail.dart';
import '../models/article.dart';

class Ecran1 extends StatefulWidget{
  @override
  State<Ecran1> createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  late Future<List<Article>> futureArticle;
  MyAPI myAPI = MyAPI();

  @override
  void initState() {
    super.initState();
    futureArticle = myAPI.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureArticle,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // nombre de colonnes
            ),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Detail(article: snapshot.data![index]),
                  ));
                },
                child: Card(
                  elevation: 6,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          snapshot.data?[index].image ?? "",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data?[index].title ?? "",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${snapshot.data?[index].price.toString()} €" ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              snapshot.data![index].getEstEnFavori() ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                snapshot.data![index].changerEstEnFavori();
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