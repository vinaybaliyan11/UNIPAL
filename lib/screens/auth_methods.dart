// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tinder_clone_app/screens/storage_methods.dart';
// import 'package:flutter_tinder_clone_app/screens/user.dart' as model;

// class AuthMethods {
//   final usercredential = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<User> getUserDetails() async {
//     User currentUser = usercredential.currentUser!;

//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     return User.fromSnap(snap);
//   }

//   Future<String> signUpUser({
//     required String email,
//     required String password,
//     required String bio,
//     required String username,
//     required Uint8List file,
//   }) async {
//     String res = "Some error occured";
//     try {
//       if (email.isNotEmpty ||
//           password.isNotEmpty ||
//           bio.isNotEmpty ||
//           username.isNotEmpty ||
//           file != null) {
//         UserCredential cred = await usercredential.createUserWithEmailAndPassword(
//             email: email, password: password);

//         String photoUrl = await StorageMethods()
//             .uploadImageToStorage('profilePics', file, false);

//         User user = User(
//           username: username,
//           uid: cred.user!.uid,
//           email: email,
//           bio: bio,
//           followers: [],
//           following: [],
//           photoUrl: photoUrl,
//         );

//         await _firestore
//             .collection('users')
//             .doc(cred.user!.uid)
//             .set(user.toJson());

//         res = "success";
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }

//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     String res = "Some error occured";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         await usercredential.signInWithEmailAndPassword(
//             email: email, password: password);
//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }

//   Future<void> signOut() async {
//     await usercredential.signOut();
//   }
// }
