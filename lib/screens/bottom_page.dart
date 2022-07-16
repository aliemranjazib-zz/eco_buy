import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/screens/bottom_screens/cart_screen.dart';
import 'package:eco_buy/screens/bottom_screens/checkout_screen.dart';
import 'package:eco_buy/screens/bottom_screens/favourite-screen.dart';
import 'package:eco_buy/screens/bottom_screens/home_screen.dart';
import 'package:eco_buy/screens/bottom_screens/product_screen.dart';
import 'package:eco_buy/screens/bottom_screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget {
  // const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;

  void cartItemsLength() {
    FirebaseFirestore.instance.collection('cart').get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        setState(() {
          length = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItemsLength();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shop)),
          BottomNavigationBarItem(
              icon: Stack(
            children: [
              Icon(Icons.add_shopping_cart),
              Positioned(
                  top: 1,
                  right: 1,
                  child: length == 0
                      ? Container()
                      : Stack(
                          children: [
                            Icon(
                              Icons.brightness_1,
                              size: 20,
                              color: Colors.green,
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "$length",
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        ))
            ],
          )),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: HomeScreen());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProductScreen());
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: CartScreen());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: FavouriteScreen());
              }));
            case 4:
              if (FirebaseAuth.instance.currentUser!.displayName == null) {
                return CupertinoTabView(builder: ((context) {
                  return CupertinoPageScaffold(child: ProfileScreen());
                }));
              }
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: CheckOutScreen());
              }));
            case 5:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProfileScreen());
              }));

            default:
          }
          return HomeScreen();
        });
  }
}
