import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/categoryModel.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/category_home_boxex.dart';
import '../widgets/home_cards.dart';

// List categories = [
//   "GROCERY",
//   "ELECTRONICES",
//   "COSMETICS",
//   "PHARMACY",
//   "GARMENTS"
// ];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List images = [
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191_960_720.jpg",
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191_960_720.jpg",
  ];

  List popularItems = [];

  getDate() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          print(e["productName"]);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getDate();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: RichText(
                      text: const TextSpan(
                children: [
                  TextSpan(
                    text: "ECO ",
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "BUY",
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))),
              const CategoryHomeBoxes(),
              // carousel(images: images),
              Text(
                "POPULAR ITEMS",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class carousel extends StatelessWidget {
//   const carousel({
//     Key? key,
//     required this.images,
//   }) : super(key: key);

//   final List images;

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//         items: images
//             .map((e) => Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(25),
//                         child: CachedNetworkImage(
//                           imageUrl: e,
//                           placeholder: (c, i) =>
//                               Center(child: Image.asset(categories[0].image!)),
//                           width: double.infinity,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             gradient: LinearGradient(colors: [
//                               Colors.blueAccent.withOpacity(0.3),
//                               Colors.redAccent.withOpacity(0.3),
//                             ])),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       left: 20,
//                       child: Container(
//                         color: Colors.black.withOpacity(0.5),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             "TITLE",
//                             style: TextStyle(fontSize: 20, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ))
//             .toList(),
//         options: CarouselOptions(
//           height: 200,
//           autoPlay: true,
//         ));
//   }
// }
