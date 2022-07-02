import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Cart {
  String? id;
  String? name;
  int? quantity;
  int? price;
  String? image;
  Cart({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.price,
    this.quantity,
  });

  static Future<void> addtoCart(Cart cart) async {
    CollectionReference db = FirebaseFirestore.instance.collection("cart");
    Map<String, dynamic> data = {
      "id": cart.id,
      "productName": cart.name,
      "image": cart.image,
      "quantity": cart.quantity,
      "price": cart.price,
    };
    await db.add(data);
  }
}
