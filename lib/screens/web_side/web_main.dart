import 'package:eco_buy/screens/web_side/addProducts_screen.dart';
import 'package:eco_buy/screens/web_side/dashboard_screen.dart';
import 'package:eco_buy/screens/web_side/deleteProducts_screen.dart';
import 'package:eco_buy/screens/web_side/updateProduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
  // const WebMainScreen({Key? key}) : super(key: key);
  static const String id = "webmain";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedSCreen = DashBoardScreen();

  chooseScreens(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          selectedSCreen = DashBoardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedSCreen = AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedSCreen = UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedSCreen = DeleteProductScreen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("ADMIN"),
        ),
        sideBar: SideBar(
            backgroundColor: Colors.black,
            textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            onSelected: (item) {
              chooseScreens(item);
            },
            items: const [
              AdminMenuItem(
                title: "DASHBOARD",
                icon: Icons.dashboard,
                route: DashBoardScreen.id,
              ),
              AdminMenuItem(
                title: "ADD PRODUCTS",
                icon: Icons.add,
                route: AddProductScreen.id,
              ),
              AdminMenuItem(
                title: "UPDATE PRODUCTS",
                icon: Icons.update,
                route: UpdateProductScreen.id,
              ),
              AdminMenuItem(
                title: "DELETE PRODUCTS",
                icon: Icons.delete,
                route: DeleteProductScreen.id,
              ),
              AdminMenuItem(
                title: "CART ITEMS",
                icon: Icons.shop,
              ),
            ],
            selectedRoute: WebMainScreen.id),
        body: selectedSCreen);
  }
}
