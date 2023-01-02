import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/screens/user_provider.dart';
import 'package:flutter_tinder_clone_app/screens/global_variable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    // UserProvider _userProvider = Provider.of<UserProvider>(context , listen: false);
    // await _userProvider.refreshUser();
  } 

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webScreenLayout;
          // web screen
        }
        return widget.mobileScreenLayout;
        // mobile screen
      },
    );
  }
}
