class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;
  final int categoryId; // Added to establish relationship with Category

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.categoryId, // Required Category ID
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'categoryId': categoryId, 
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
      categoryId: json['categoryId'], 
    );
  }
}
