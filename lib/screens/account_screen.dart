import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_tinder_clone_app/common/color_constants.dart';
import 'package:flutter_tinder_clone_app/data/account_json.dart';
import 'package:flutter_tinder_clone_app/screens/add_image.dart';
import 'package:flutter_tinder_clone_app/screens/add_info.dart';
import 'package:flutter_tinder_clone_app/screens/login.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart';
import 'package:flutter_tinder_clone_app/screens/post.dart';
import 'package:flutter_tinder_clone_app/screens/signup.dart';
import 'package:flutter_tinder_clone_app/screens/storage_method.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart'
    as model;
import 'package:flutter_tinder_clone_app/screens/user_provider.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var userdata = {};
  User user = FirebaseAuth.instance.currentUser!;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) {
    //   this.loggedInUser = UserModel.fromMap(value.data());
    //   setState(() {});
    // });
    getData();
  }

   getData() async {
    var usersnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    //   .then((value) {
    // this.loggedInUser = UserModel.fromMap(value.data());
    // }
    userdata = usersnap.data()!;
    setState(() {});
  }

  Uint8List? _image;

  //upload post
  Future<String> uploadProfile(
    Uint8List file,
    String uid,
  ) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      UserModel userModel = UserModel();
      userModel.profilePic = photoUrl;

      CollectionReference collection =
          FirebaseFirestore.instance.collection("users");
      DocumentReference document = collection.doc(user.uid);
      document.update({"profilePic": photoUrl});

      // FirebaseFirestore.instance
      //     .collection("users")
      //     .document(doc_id)
      //     .updateData({"profilePic": photoUrl});

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set(user.toJson());

      res = "success";
      getData();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 181, 216),
      body: getBody(),
    );
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      uploadProfile(image, user.uid);
    });
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    // final User user = Provider.of<UserProvider>(context).getUser as User;
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: size.width,
        height: size.height * 0.60,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 163, 221, 252),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.kGrey.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
                // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              userdata['profilePic'] != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(userdata['profilePic']),
                    )
                  : CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage("assets/images/person.jpg"),
                    ),
              SizedBox(
                height: 15,
              ),
              Text(
                (userdata['firstName'] +
                    " " +
                    userdata['secondName']).toUpperCase(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.kWhite,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.kGrey.withOpacity(0.1),
                              spreadRadius: 10,
                              blurRadius: 15,
                              // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            logout(context);
                          },
                          icon: Icon(Icons.logout),
                          color: ColorConstants.kBlue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("LOGOUT",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.kBlue)),

                      // Text(
                      //   "SETTINGS",
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w600,
                      //     color: ColorConstants.kGrey.withOpacity(0.8),
                      //   ),
                      // )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () => selectImage(),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorConstants.kBlue,
                                        ColorConstants.kBlue
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstants.kGrey
                                            .withOpacity(0.1),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 45,
                                    color: ColorConstants.kWhite,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 0,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.kWhite,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstants.kGrey
                                            .withOpacity(0.1),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: ColorConstants.kBlue,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          loggedInUser.profilePic == null
                              ? "ADD PROFILE PHOTO"
                              : "EDIT PHOTO",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.kBlue.withOpacity(0.8)),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => AddInfoScreen()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstants.kGrey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 15,
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 35,
                            color: ColorConstants.kBlue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "EDIT INFO",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.kBlue.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
