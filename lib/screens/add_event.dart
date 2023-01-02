import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tinder_clone_app/firebase_options.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_tinder_clone_app/screens/college_events.dart';
import 'package:flutter_tinder_clone_app/screens/login.dart';
import 'package:flutter_tinder_clone_app/screens/models/event_model.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart'
    as model;

import 'package:flutter_tinder_clone_app/screens/models/user_model.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  // final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final collegenameEditingController = new TextEditingController();
  final eventnameEditingController = new TextEditingController();
  final dateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final collegenameField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: collegenameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("College name field cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Value(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          collegenameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.school_rounded,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "College Name",
          hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //second name field
    final eventnameField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: eventnameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Event field cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          eventnameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.event,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Event Name",
          hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //email field
    final dateField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: dateController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          dateController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.date_range_outlined,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Date",
          hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //password field

    //signup button
    final addEventButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            postDetailsToFirestore();
          },
          child: Text(
            "ADD EVENT",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 26, 45),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 200,
                      //margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/girls/unipallogo.PNG'),
                              fit: BoxFit.fill),
                          //border: Border.all(color: Colors.blue, width: 10),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 45),
                    collegenameField,
                    SizedBox(height: 20),
                    eventnameField,
                    SizedBox(height: 20),
                    dateField,
                    SizedBox(height: 20),
                    addEventButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    EventModel eventModel = EventModel();

    // writing all the values
    eventModel.collegeName = collegenameEditingController.text;
    eventModel.eventName = eventnameEditingController.text;
    eventModel.date = dateController.text;
    eventModel.uid = user?.uid;
    // eventModel.eventId = await Firestore.instance.collection('events').getDocuments() ;

    // var collection = FirebaseFirestore.instance.collection('events');
    // var querySnapshots = await collection.get();
    // for (var snapshot in querySnapshots.docs) {
    //   var documentID = snapshot.id;
    //   print(documentID);
    // }

    // var collection = FirebaseFirestore.instance.collection('collection');
    // var docRef = await collection.add();
    // var documentId = docRef.id;

    await firebaseFirestore.collection("events").doc().set(eventModel.toMap());
    
    Fluttertoast.showToast(msg: "Event added successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => CollegeEvents()),
        (route) => false);
  }
}


  // void addevent(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       await _auth
  //           .createUserWithEmailAndPassword(email: email, password: password)
  //           .then((value) => {postDetailsToFirestore()})
  //           .catchError((e) {
  //         Fluttertoast.showToast(msg: e!.message);
  //       });
  //     } on FirebaseAuthException catch (error) {
  //       switch (error.code) {
  //         case "invalid-email":
  //           errorMessage = "Your email address appears to be malformed.";
  //           break;
  //         case "wrong-password":
  //           errorMessage = "Your password is wrong.";
  //           break;
  //         case "user-not-found":
  //           errorMessage = "User with this email doesn't exist.";
  //           break;
  //         case "user-disabled":
  //           errorMessage = "User with this email has been disabled.";
  //           break;
  //         case "too-many-requests":
  //           errorMessage = "Too many requests";
  //           break;
  //         case "operation-not-allowed":
  //           errorMessage = "Signing in with Email and Password is not enabled.";
  //           break;
  //         default:
  //           errorMessage = "An undefined Error happened.";
  //       }
  //       Fluttertoast.showToast(msg: errorMessage!);
  //       print(error.code);
  //     }
  //   }
  // }

  // postDetailsToFirestore() async {
  //   // calling our firestore
  //   // calling our user model
  //   // sedning these values

  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   UserModel userModel = UserModel();

  //   // writing all the values
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.firstName = firstNameEditingController.text;
  //   userModel.secondName = secondNameEditingController.text;

  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(msg: "Account created successfully :) ");

  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => WelcomeScreen()),
  //       (route) => false);
  // }
// }














