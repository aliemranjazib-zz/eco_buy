import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/screens/web_side/update_complete_screen.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatelessWidget {
  // const UpdateProductScreen({Key? key}) : super(key: key);
  static const String id = "updateproduct";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const Text(
              "UPDATE PRODUCT",
              style: EcoStyle.boldStyle,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return const Center(child: Text("NO DATA EXISTS"));
                }
                final data = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, UpdateCompleteProductScreen.id);
                                },
                                child: ListTile(
                                  title: Text(
                                    data[index]['productName'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
