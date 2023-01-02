import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tinder_clone_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/home_page_screen.dart';
import 'package:flutter_tinder_clone_app/screens/signup.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: emailController,
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
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          iconColor: Colors.white,
          fillColor: Colors.white,
          hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.mail,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
          ),
        ));

    //password field
    final passwordField = TextFormField(
        style: TextStyle(color: Colors.white),
        autofocus: false,
        controller: passwordController,
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
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          iconColor: Colors.white,
          prefixIcon: Icon(Icons.vpn_key,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          fillColor: Colors.white,
          hintStyle: const TextStyle(
              fontSize: 20.0, color: Colors.white),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),), 
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)
            
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, ),
          )),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 26, 45),
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
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => WelcomeScreen())),
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
}































// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   //form key
//   final _formkey = GlobalKey<FormState>();
//   //editing controller
//   late final TextEditingController emailcontroller;
//   late final TextEditingController passwordcontroller;

//   @override
//   void initState() {
//     emailcontroller = TextEditingController();
//     passwordcontroller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     emailcontroller.dispose();
//     passwordcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     future:
//     Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//     //email field
//     final _emailField = TextFormField(
//       autofocus: false,
//       controller: emailcontroller,
//       keyboardType: TextInputType.emailAddress,
//       onSaved: (value) {
//         emailcontroller.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(
//           Icons.mail,
//           color: Colors.white,
//         ),
//         // suffixIcon: Icon(
//         //   Icons.check_circle,
//         //   color: Colors.white,
//         // ),
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//         hintText: "Email",
//         hintStyle: const TextStyle(
//             fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         enabledBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.white)),
//       ),
//     );
//     final passwordfield = TextFormField(
//       autofocus: false,
//       controller: passwordcontroller,
//       onSaved: (value) {
//         passwordcontroller.text = value!;
//       },
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

//     final loginButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.blueAccent,
//       child: MaterialButton(
//           onPressed: () async {
//             final email = emailcontroller.text.trim();
//             final password = passwordcontroller.text.trim();

//             try {
//               final userCredential = await FirebaseAuth.instance
//                   .signInWithEmailAndPassword(email: email, password: password);
//               print(userCredential);
//               Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
//             } on FirebaseAuthException catch (e) {
//               if (e.code == 'user-not-found') {
//                 print('User not found');
//               } else if (e.code == 'wrong-password') {
//                 print('Wrong password');
//                 print(e.code);
//               } else if (e.code == 'invalid-email') {
//                 print('Invalid Email');
//               } else {
//                 print('Successful login');
//               }
//             }
//           },
//           padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           minWidth: MediaQuery.of(context).size.width,
//           child: const Text(
//             "Login",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//           )),
//     );

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 4, 26, 45),
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
//               _emailField,
//               const SizedBox(height: 35),
//               passwordfield,
//               const SizedBox(height: 45),
//               loginButton,
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text("Don't have an acoount?",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       )),
//                   TextButton(
//                     child: const Text(
//                       'Sign Up',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.amber,
//                           decoration: TextDecoration.underline),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RegistrationScreen()),
//                       );
//                     },
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       )))),
//     );
//   }
// }






















