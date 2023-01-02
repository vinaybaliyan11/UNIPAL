import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tinder_clone_app/common/color_constants.dart';
import 'package:flutter_tinder_clone_app/data/explore_json.dart';
import 'package:flutter_tinder_clone_app/data/icons.dart';
import 'package:flutter_tinder_clone_app/screens/description.dart';
import 'package:flutter_tinder_clone_app/screens/login.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  late CardController controller;

  int userIndex = 0;

  List itemsTemp = [];
  int itemLength = 0;
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
      backgroundColor: ColorConstants.kBlue,
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
          return Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: Container(
                height: size.height,
                child: TinderSwapCard(
                  totalNum: snapshot.data!.docs.length,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                  minWidth: MediaQuery.of(context).size.width * 0.75,
                  minHeight: MediaQuery.of(context).size.height * 0.6,
                  cardBuilder: (context, index) {
                    userIndex = index;
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: ColorConstants.kBlack.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DescriptionScreen(index)));
                          },
                          child: Stack(
                            children: [
                              snapshot.data!.docs[index].data()['profilePic'] !=
                                      null
                                  ? Container(
                                      width: size.width,
                                      height: size.height,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]
                                                .data()['profilePic']),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Container(
                                      width: size.width,
                                      height: size.height,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/person.jpg"),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                              Container(
                                width: size.width,
                                height: size.height,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      ColorConstants.kBlack.withOpacity(0.25),
                                      ColorConstants.kBlack.withOpacity(0),
                                    ],
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15, left: 22),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.72,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                                  .data()[
                                                              'firstName'] !=
                                                          null
                                                      ? snapshot
                                                          .data!.docs[index]
                                                          .data()['firstName']
                                                      : "Loading...",
                                                  style: TextStyle(
                                                      color:
                                                          ColorConstants.kWhite,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                              .data()['age'] !=
                                                          null
                                                      ? snapshot
                                                          .data!.docs[index]
                                                          .data()['age']
                                                      : "Loading...",
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstants.kWhite,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                                  .data()[
                                                              'empType'] !=
                                                          null
                                                      ? snapshot
                                                          .data!.docs[index]
                                                          .data()['empType']
                                                      : "Loading...",
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstants.kWhite,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 18,
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                                  .data()[
                                                              'currComp'] !=
                                                          null
                                                      ? snapshot
                                                          .data!.docs[index]
                                                          .data()['currComp']
                                                      : "Loading...",
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstants.kWhite,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Container(
                                          //     width: size.width * 0.2,
                                          //     child: Center(
                                          //       child: Icon(
                                          //         Icons.info,
                                          //         color: ColorConstants.kWhite,
                                          //         size: 28,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  cardController: controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                    } else if (align.x > 0) {
                      sendMail(snapshot.data!.docs[userIndex].data()['email']);
                      //Card is RIGHT swiping
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                    if (index == (snapshot.data!.docs.length - 1)) {
                      setState(() {
                        itemLength = snapshot.data!.docs.length - 1;
                      });
                    }
                  },
                ),
              ));
        });
  }

  sendMail(String mailId) async {
    final Email email = Email(
      body: 'Hey, I want to connect with you.',
      subject: 'Connection Request',
      recipients: [mailId],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      Fluttertoast.showToast(msg: "Mail sent successfully :) ");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error in sending email..");
    }
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
