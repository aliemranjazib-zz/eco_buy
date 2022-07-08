import 'package:eco_buy/screens/auth_screens/login_screen.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/ecotextfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // const SignupScreen({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypepasswordC = TextEditingController();
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();

  bool ispassword = true;
  bool isretypepassword = true;
  bool formStateLoading = false;
  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypepasswordC.dispose();
    super.dispose();
  }

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
      if (passwordC.text == retypepasswordC.text) {
        String? accountstatus =
            await FirebaseServices.createAccount(emailC.text, passwordC.text);

        //print(accountstatus);
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }

        //  Navigator.push(
        //       context, MaterialPageRoute(builder: (_) => LoginScreen()));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "WELCOME \n Please Create your Account",
                  textAlign: TextAlign.center,
                  style: EcoStyle.boldStyle,
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "email is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassowrd: false,
                                controller: emailC,
                                hintText: "Email...",
                                icon: const Icon(Icons.email),
                              ),
                              EcoTextField(
                                maxLines: 1,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                focusNode: passwordfocus,
                                inputAction: TextInputAction.next,
                                isPassowrd: ispassword,
                                controller: passwordC,
                                hintText: "Password...",
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
                              ),
                              EcoTextField(
                                maxLines: 1,
                                isPassowrd: isretypepassword,
                                controller: retypepasswordC,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                hintText: "Retype Password...",
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isretypepassword = !isretypepassword;
                                    });
                                  },
                                  icon: isretypepassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                              EcoButton(
                                title: "SIGNUP",
                                isLoginButton: true,
                                onPress: () {
                                  submit();
                                },
                                isLoading: formStateLoading,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                EcoButton(
                  title: "BACK TO LOGIN",
                  onPress: () {
                    Navigator.pop(context);
                  },
                  isLoginButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
