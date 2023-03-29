import 'package:cloud_firestore/cloud_firestore.dart';

class Images {
  String? id;
  String? image;

  Images({this.id, this.image});

  Images.fromMap(DocumentSnapshot data) {
    id = data.id;
    image = data["image"];
  }
}
