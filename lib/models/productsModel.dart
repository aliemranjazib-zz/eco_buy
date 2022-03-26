import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? id;
  String? productName;
  String? detail;
  String? brand;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<dynamic>? imageUrls;
  bool? isSale;
  bool? isPopular;
  bool? isFavourite;

  Products({
    this.category,
    this.id,
    this.productName,
    this.detail,
    this.price,
    this.brand,
    this.discountPrice,
    this.serialCode,
    this.imageUrls,
    this.isSale,
    this.isPopular,
    this.isFavourite,
  });

  static Future<void> addProducts(Products products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");
    Map<String, dynamic> data = {
      "category": products.category,
      "productName": products.productName,
      "id": products.id,
      "detail": products.detail,
      "price": products.price,
      "brand": products.brand,
      "discountPrice": products.discountPrice,
      "serialCode": products.serialCode,
      "imageUrls": products.imageUrls,
      "isOnSale": products.isSale,
      "isPopular": products.isPopular,
      "isFavourite": products.isFavourite,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(String id, Products updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": updateProducts.category,
      "productName": updateProducts.productName,
      "id": updateProducts.id,
      "detail": updateProducts.detail,
      "price": updateProducts.price,
      "brand": updateProducts.brand,
      "discountPrice": updateProducts.discountPrice,
      "serialCode": updateProducts.serialCode,
      "imageUrls": updateProducts.imageUrls,
      "isOnSale": updateProducts.isSale,
      "isPopular": updateProducts.isPopular,
      "isFavourite": updateProducts.isFavourite,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
