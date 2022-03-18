import 'package:eco_buy/widgets/eco_button.dart';
import 'package:flutter/material.dart';

class EcoDialogue extends StatelessWidget {
  final String? title;
  const EcoDialogue({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        EcoButton(
          title: 'CLOSE',
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
