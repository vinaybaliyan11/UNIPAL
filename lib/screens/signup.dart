import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tinder_clone_app/firebase_options.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_tinder_clone_app/screens/login.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart'
    as model;

import 'package:flutter_tinder_clone_app/screens/models/user_model.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
                  hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
                  hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //email field
    final emailField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
                  hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //password field
    final passwordField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
            hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
           iconColor: Colors.white,
          prefixIcon: Icon(Icons.vpn_key , color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
            hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "SignUp",
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
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false);
  }
}

















// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// var userCredential;

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   //form key
//   final _formkey = GlobalKey<FormState>();
//   //editing controller
//   late final TextEditingController firstnamecontroller;
//   late final TextEditingController secondnamecontroller;
//   late final TextEditingController passwordcontroller;
//   late final TextEditingController confirmpasswordcontroller;
//   late final TextEditingController emailcontroller;

//   @override
//   void initState() {
//     firstnamecontroller = TextEditingController();
//     secondnamecontroller = TextEditingController();
//     emailcontroller = TextEditingController();
//     passwordcontroller = TextEditingController();
//     confirmpasswordcontroller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     firstnamecontroller.dispose();
//     secondnamecontroller.dispose();
//     emailcontroller.dispose();
//     passwordcontroller.dispose();
//     confirmpasswordcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //email field
//     Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//     final _firstField = TextFormField(
//       autofocus: false,
//       controller: firstnamecontroller,
//       keyboardType: TextInputType.emailAddress,
//       // onFieldSubmitted: (value) {
//       //   firstnamecontroller.text = value!;
//       // },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.account_circle,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: "First Name",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.white)),
//       ),
//     );
//     final _secondField = TextFormField(
//       autofocus: false,
//       controller: secondnamecontroller,
//       // onFieldSubmitted: (value) {
//       //   secondnamecontroller.text = value!;
//       // },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.account_circle,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: "Second Name",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//       ),
//     );
//     final emailfield = TextFormField(
//       autofocus: false,
//       controller: emailcontroller,
//       // onFieldSubmitted: (value) {
//       //   emailcontroller.text = value!;
//       // },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.mail,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: "Email",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//       ),
//     );
//     final passwordfield = TextFormField(
//       autofocus: false,
//       controller: passwordcontroller,
//       // onFieldSubmitted: (value) {
//       //   passwordcontroller.text = value!;
//       // },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.vpn_key,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: "Password",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//       ),
//     );
//     final confirmpasswordfield = TextFormField(
//       autofocus: false,
//       controller: confirmpasswordcontroller,
//       obscureText: true,
//       // onFieldSubmitted: (value) {
//       //   confirmpasswordcontroller.text = value!;
//       // },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.vpn_key,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: " Confirm Password",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//       ),
//     );

//     final signupButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.blueAccent,
//       child: MaterialButton(
//           onPressed: () async {
//             final email = emailcontroller.text;
//             final password = passwordcontroller.text;
//             try {
//               userCredential = await FirebaseAuth.instance
//                   .createUserWithEmailAndPassword(
//                       email: email, password: password);
//               print(userCredential);
//               model.User user = model.User(
//                 firstname: firstnamecontroller.text,
//                 lastname: " ",
//                 uid: userCredential.user!.uid,
//                 email: email,
//                 photoUrl: '',
//               );

//               print(user);
//               print("TANISH");

//               await FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(userCredential.user!.uid)
//                   .set(user.toJson());

//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LoginScreen()),
//                       );

//             } on FirebaseAuthException catch (e) {
//               if (e.code == 'weak-password') {
//                 print('Weak password');
//               } else if (e.code == 'email-already-in-use') {
//                 print('Email already in use');
//               } else {
//                 print(e.code);
//               }
//             }
//           },
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           minWidth: MediaQuery.of(context).size.width,
//           child: const Text(
//             "SignUp",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//           )),
//     );

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 4, 26, 45),
//       appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 70, 219, 236),
//           iconTheme: IconThemeData(color: Colors.black),
//           title: Text("Back to Login Page",
//               style: TextStyle(color: Colors.black))),
//       body: Center(
//           child: SingleChildScrollView(
//               child: Container(
//                   //color: Colors.white,
//                   child: Padding(
//         padding: const EdgeInsets.all(36.0),
//         child: Form(
//           key: _formkey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 width: 200,
//                 //margin: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     image: const DecorationImage(
//                         image: AssetImage('assets/images/girls/unipallogo.PNG'),
//                         fit: BoxFit.fill),
//                     //border: Border.all(color: Colors.blue, width: 10),
//                     borderRadius: BorderRadius.circular(50)),
//               ),
//               const SizedBox(height: 45),
//               _firstField,
//               const SizedBox(height: 35),
//               _secondField,
//               const SizedBox(height: 45),
//               emailfield,
//               const SizedBox(height: 45),
//               passwordfield,
//               const SizedBox(height: 45),
//               confirmpasswordfield,
//               const SizedBox(height: 45),
//               signupButton,
//               const SizedBox(height: 15),
//             ],
//           ),
//         ),
//       )))),
//     );
//   }
// }

