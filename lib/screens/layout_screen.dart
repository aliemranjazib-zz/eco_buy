import 'package:eco_buy/screens/landing_screen.dart';
import 'package:eco_buy/screens/web_side/web_login.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return WebLoginScreen();
        } else {
          return LandingScreen();
        }
      },
    );
  }
}
