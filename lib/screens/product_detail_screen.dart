import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/productsModel.dart';
import '../widgets/header.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? id;
  const ProductDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Products> allProducts = [];

  getDate() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["id"] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var item in e["imageUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Products(
                    id: e["id"],
                    detail: e["detail"],
                    productName: e["productName"],
                    imageUrls: e["imageUrls"],
                  ),
                );
              });
            }
          }
        }
      });
    });
    // print(allProducts[0].discountPrice);
  }

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({"pid": allProducts.first.id});
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  void initState() {
    getDate();
    super.initState();
  }

  bool isfvrt = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                child: Header(
                  title: "${allProducts.first.productName}",
                ),
                preferredSize: Size.fromHeight(5.h)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    allProducts[0].imageUrls![selectedIndex],
                    height: 30.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          allProducts[0].imageUrls!.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 12.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  allProducts[0].imageUrls![index],
                                  height: 9.h,
                                  width: 9.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     height: 7.h,
                  //     width: 35.w,
                  //     decoration: BoxDecoration(
                  //       color: Colors.black,
                  //       borderRadius: BorderRadius.circular(1),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Center(
                  //           child: Text("340 \$",
                  //               style: TextStyle(color: Colors.white))),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 1.h,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('items')
                          .where('pid', isEqualTo: allProducts.first.id)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return Text("");
                        }
                        return IconButton(
                            onPressed: () {
                              snapshot.data!.docs.length == 0
                                  ? addToFavrourite()
                                  : removeToFavrourite(
                                      snapshot.data!.docs.first.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: snapshot.data!.docs.length == 0
                                  ? Colors.black
                                  : Colors.red,
                            ));
                      }),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: 30.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        allProducts.first.detail!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.exposure_minus_1),
                        ),
                        Text(
                          "01",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.exposure_plus_1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
  }
}
