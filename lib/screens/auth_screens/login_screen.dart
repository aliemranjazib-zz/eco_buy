import 'package:eco_buy/screens/bottom_screens/home_screen.dart';
import 'package:eco_buy/screens/auth_screens/signup_screen.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/ecotextfield.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  bool ispassword = true;

  TextEditingController passwordC = TextEditingController();
  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });

      String? accountstatus =
          await FirebaseServices.signInAccount(emailC.text, passwordC.text);

      //print(accountstatus);
      if (accountstatus != null) {
        ecoDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "WELCOME \n Please Login First",
                textAlign: TextAlign.center,
                style: EcoStyle.boldStyle,
              ),
              Column(
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          EcoTextField(
                            controller: emailC,
                            hintText: "Email...",
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "email is badly formated";
                              }
                              return null;
                            },
                          ),
                          EcoTextField(
                            controller: passwordC,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispassword = !ispassword;
                                });
                              },
                              icon: ispassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            hintText: "Password...",
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password is badly formated";
                              }
                              return null;
                            },
                          ),
                          EcoButton(
                            title: "LOGIN",
                            isLoading: formStateLoading,
                            isLoginButton: true,
                            onPress: () {
                              submit();
                            },
                          ),
                        ],
                      )),
                ],
              ),
              EcoButton(
                title: "CREATE NEW ACCOUNT",
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()));
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
