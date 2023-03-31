import 'package:cloud_firestore/cloud_firestore.dart';

class ProductType {
  String? id;
  String? type;

  ProductType({this.id, this.type});

  ProductType.fromMap(DocumentSnapshot data) {
    id = data.id;
    type = data["type"];
    
  }
}
