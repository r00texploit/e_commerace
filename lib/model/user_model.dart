import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? shop_name;
  int? number;

  Users({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.number,
    required this.shop_name,
  });

  Users.fromMap(DocumentSnapshot data) {
    id = data.id;
    // shop_name = data["shop_name"];
    name = data["name"];
    email = data["email"];
    number = data["number"];
    uid = data["uid"];
  }
}
