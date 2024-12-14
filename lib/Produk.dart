import 'dart:convert';

class Produk {
  final String name;
  final String image;
  final double price;
  final String description;
  int quantity;

  Produk({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.quantity = 1,
  });

  // Mengonversi objek Produk menjadi Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  // Membuat objek Produk dari Map (JSON)
  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      image: map['image'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      quantity: map['quantity'] ?? 1,
    );
  }

  // Mengonversi objek Produk menjadi string JSON
  String toJson() => json.encode(toMap());

  // Membuat objek Produk dari string JSON
  factory Produk.fromJson(String source) => Produk.fromMap(json.decode(source));
}
