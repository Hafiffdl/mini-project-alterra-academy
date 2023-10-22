class Product {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  double? price;

  Product({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: map['price'],
    );
  }
}
