import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? type;
  String? name;
  String? description;
  String? image;
  int? price;
  int? number;
  List? color;

  Product(
      {this.id,
      required this.type,
      required this.price,
      required this.color,
      required this.image,
      required this.name,
      required this.description,
      required this.number});

  Product.fromMap(DocumentSnapshot data) {
    id = data.id;
    type = data["type"];
    price = data["price"];
    name = data["name"];
    image = data["image"];
    color = data["color"];
    number = data["number"];
    description = data["description"];
  }
}
