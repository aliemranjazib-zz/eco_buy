import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:flutter/material.dart';

import '../widgets/home_cards.dart';

List categories = [
  "GROCERY",
  "ELECTRONICES",
  "COSMETICS",
  "PHARMACY",
  "GARMENTS"
];

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List images = [
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191_960_720.jpg",
    "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/24/21/01/thermometer-1539191_960_720.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "HOME SCREEN",
                  style: EcoStyle.boldStyle,
                ),
              ),
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    e,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(colors: [
                                        Colors.blueAccent.withOpacity(0.3),
                                        Colors.redAccent.withOpacity(0.3),
                                      ])),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "TITLE",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                  )),
              HomeCards(title: categories[0]),
              HomeCards(title: categories[1]),
              HomeCards(title: categories[2]),
              HomeCards(title: categories[3]),
              HomeCards(title: categories[4]),
            ],
          ),
        ),
      ),
    );
  }
}
