import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({Key? key}) : super(key: key);
  String? profilePic;
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? downloadUrl;
  bool selection = false;

  // String? buttonText;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('please complete profile firstly')));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          nameC.text = snapshot['name'];
          phoneC.text = snapshot['phone'];
          houseC.text = snapshot['house'];
          cityC.text = snapshot['city'];
          streetC.text = snapshot['street'];
          addressC.text = snapshot['address'];
          profilePic = snapshot['profilePic'];
        });
      }
    });
    super.initState();
  }

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        if (pickImage != null) {
                          setState(() {
                            profilePic = pickImage.path;
                            selection = true;
                          });
                        }
                      },
                      child: Container(
                        child: profilePic == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.deepPurple,
                                child: Image.asset(
                                  'assets/c_images/add_pic.png',
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : profilePic!.contains('http')
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(profilePic!),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        FileImage(File(profilePic!)),
                                  ),
                      ),
                    ),
                  ),
                  EcoTextField(
                    hintText: "enter complete name",
                    controller: nameC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "enter phoneNumber",
                    controller: phoneC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "enter house no",
                    controller: houseC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "enter street ",
                    controller: streetC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "enter city",
                    controller: cityC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "enter complete address",
                    controller: addressC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoButton(
                    title: nameC.text.isEmpty ? 'SAVE' : 'Update',
                    isLoginButton: true,
                    isLoading: isSaving,
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMapMethod(
                            'TextInput.hide'); // hides keyboard
                        profilePic == null
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('select profile pic')))
                            : nameC.text.isEmpty
                                ? saveInfo()
                                : update();
                      }
                    },
                  ),
                  EcoButton(
                    onPress: () {
                      FirebaseAuth.instance.signOut();
                    },
                    title: 'SING OUT',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  update() {
    setState(() {
      isSaving = true;
    });
    if (selection == true) {
      uploadImage(File(profilePic!), 'profile').whenComplete(() {
        Map<String, dynamic> data = {
          'name': nameC.text,
          'phone': phoneC.text,
          'house': houseC.text,
          'street': streetC.text,
          'city': cityC.text,
          'address': addressC.text,
          'profilePic': downloadUrl,
        };
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(data)
            .whenComplete(() {
          FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
          setState(() {
            isSaving = false;
          });
        });
      });
    } else {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': profilePic,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isSaving = false;
        });
      });
    }
  }

  saveInfo() {
    setState(() {
      isSaving = true;
    });
    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': downloadUrl,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isSaving = false;
        });
      });
    });
  }
}
