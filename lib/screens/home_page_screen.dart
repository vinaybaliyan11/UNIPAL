import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tinder_clone_app/screens/account_screen.dart';
import 'package:flutter_tinder_clone_app/screens/chat_screen.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/like_screen.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';

import '../common/color_constants.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.kBlue,
            )),
        title: Text(
          "UNIPAL",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: ColorConstants.kBlue),
        ),
      ),
      bottomSheet: AppBarWidget(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        ExploreScreen(),
        // LikesScreen(),
        ChatScreen(),
        AccountScreen(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  BottomAppBar AppBarWidget() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/thunder_icon.svg"
          : "assets/images/thunder.svg",
      // pageIndex == 1
      //     ? "assets/images/likes_active_icon.svg"
      //     : "assets/images/likes_icon.svg",
      pageIndex == 1
          ? "assets/images/chat_active_icon.svg"
          : "assets/images/chat_icon.svg",
      pageIndex == 2
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return BottomAppBar(
      // backgroundColor: Colors.blue,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(bottomItems.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(
                bottomItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
