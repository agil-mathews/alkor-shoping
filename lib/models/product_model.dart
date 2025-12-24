class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final String category;
  final double price;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price, 
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: (json['price'] as num).toDouble(), 
      category: json['category'],
    );
  }
}
