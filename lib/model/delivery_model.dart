import 'package:cloud_firestore/cloud_firestore.dart';

class Delivery {
  String? id;
  String? name;

  Delivery({this.id, this.name});

  Delivery.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
  }
}
