import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/common/color_constants.dart';
import 'package:flutter_tinder_clone_app/data/likes_json.dart';
import 'package:flutter_tinder_clone_app/screens/college_events.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/home_page_screen.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart';
import 'package:flutter_tinder_clone_app/screens/signup.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
  var userdata = {};
  User user = FirebaseAuth.instance.currentUser!;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 26, 45),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(padding: EdgeInsets.only(bottom: 90), children: [
      Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 280,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 175, 222, 239),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.kGrey.withOpacity(0.1),
                    spreadRadius: 30,
                    blurRadius: 20,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "HEY \n ${userdata['firstName']} ${userdata['secondName']}".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Range over all you can...!!",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 100,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePageScreen()));
            },
            child: Container(
              width: (size.width - 15) / 2,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "FIND MATE/MENTOR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ignore: dead_code
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 100,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CollegeEvents()));
            },
            child: Container(
              width: (size.width - 15) / 2,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "COLLEGE EVENTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ignore: dead_code
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 100,
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => HomePageScreen()));
            },
            child: Container(
              width: (size.width - 15) / 2,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "REFERRAL BUCKET ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ignore: dead_code
        ),
      ),
      SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 100,
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => HomePageScreen()));
            },
            child: Container(
              width: (size.width - 15) / 2,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "ACTIVITY TRACKER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ignore: dead_code
        ),
      )
    ]);

    //       }),
    //     ),
    //   )
    // ],
    // );
  }
}
