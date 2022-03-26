import 'package:flutter/material.dart';

class BottomPage extends StatelessWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.home),
      ),
      body: Text("OKKKKKKKKKKKK"),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "favourite",
        ),
        BottomNavigationBarItem(
            label: "cart",
            icon: Icon(
              Icons.shop,
            )),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "profile",
        ),
      ]),
    );
  }
}
