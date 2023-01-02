import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/screens/account_screen.dart';
import 'package:flutter_tinder_clone_app/screens/chat_screen.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/like_screen.dart';
// import 'package:instagram_flutter/screens/add_post_screen.dart';
// import 'package:instagram_flutter/screens/feed_screen.dart';
// import 'package:instagram_flutter/screens/profile_screen.dart';
// import 'package:instagram_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  ExploreScreen(),
  LikesScreen(),
  ChatScreen(),
  AccountScreen(),
  // const FeedScreen(),
  // const SearchScreen(),
  // const AddPostScreen(),
  // const Center(child: Text("Notifications", style: TextStyle(fontSize: 22))),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];
