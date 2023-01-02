import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tinder_clone_app/common/color_constants.dart';
import 'package:flutter_tinder_clone_app/data/explore_json.dart';
import 'package:flutter_tinder_clone_app/data/icons.dart';
import 'package:flutter_tinder_clone_app/screens/login.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class DescriptionScreen extends StatefulWidget {
  int index;
  DescriptionScreen(this.index);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState(this.index);
}

class _DescriptionScreenState extends State<DescriptionScreen>
    with TickerProviderStateMixin {
  // late CardController controller;
  int index;
  _DescriptionScreenState(this.index);

  List itemsTemp = [];
  int itemLength = 0;

  // var index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kBlack,
      body: getBody(),
      // bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: InkWell(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
              ),
              title: Text(
                "UNIPAL",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(255, 163, 221, 252),
                child: Column(
                  children: [
                    Container(
                      height: size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 6),
                          width: MediaQuery.of(context).size.width,
                          height: 430,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.docs[index]
                                  .data()['profilePic']),
                              // image: AssetImage("assets/images/mango.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 200,
                                height: 70,
                                child: Card(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        snapshot.data!.docs[index]
                                                    .data()['firstName'] !=
                                                null
                                            ? "Hey myself " +
                                                snapshot.data!.docs[index]
                                                    .data()['firstName']
                                            : "loading..",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                snapshot.data!.docs[index].data()['age'] != null
                                    ? "I'm " +
                                        snapshot.data!.docs[index]
                                            .data()['age'] +
                                        " years old"
                                    : "loading...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                snapshot.data!.docs[index].data()['empType'] !=
                                        null
                                    ? "I'm " +
                                        snapshot.data!.docs[index]
                                            .data()['empType']
                                    : "loading...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                snapshot.data!.docs[index].data()['currComp'] !=
                                        null
                                    ? "Currently I'm employed at " +
                                        snapshot.data!.docs[index]
                                            .data()['currComp']
                                    : "loading..",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "My hobbies are: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.data!.docs[index]
                                        .data()['hobbies']
                                        .length ==
                                    0)
                                  Text(
                                    "Still exploring....",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                for (int i = 0;
                                    i <
                                        snapshot.data!.docs[index]
                                            .data()['hobbies']
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                                    .data()['hobbies'][i] !=
                                                null
                                            ? "• " +
                                                snapshot.data!.docs[index]
                                                    .data()['hobbies'][i]
                                            : "loading..",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "My Tech Stack includes: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.data!.docs[index]
                                        .data()['tech']
                                        .length ==
                                    0)
                                  Text(
                                    "Still working on my skills....",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                for (int i = 0;
                                    i <
                                        snapshot.data!.docs[index]
                                            .data()['tech']
                                            .length;
                                    i++)
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                                    .data()['tech'][i] !=
                                                null
                                            ? "• " +
                                                snapshot.data!.docs[index]
                                                    .data()['tech'][i]
                                            : "loading..",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: ColorConstants.kWhite),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.kWhite,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.kBlack.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
