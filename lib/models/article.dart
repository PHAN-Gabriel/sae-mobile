class Article {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  static int nb = 1;

  Article(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  factory Article.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];

    if (json['tags'] != null) {
      json['tags'].forEach((t) {
        tags.add(t);
      });
    }

    return Article(
        id: json['id'] ?? -1,
        title: json['title'] ?? 'inconnu',
        price: json['price'] ?? -1,
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? '');
  }
}
