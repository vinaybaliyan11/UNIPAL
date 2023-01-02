import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/common/color_constants.dart';
import 'package:flutter_tinder_clone_app/data/likes_json.dart';
import 'package:flutter_tinder_clone_app/screens/add_event.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/get_event_details.dart';
import 'package:flutter_tinder_clone_app/screens/home_page_screen.dart';
import 'package:flutter_tinder_clone_app/screens/models/event_model.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';

class CollegeEvents extends StatefulWidget {
  @override
  _CollegeEventsState createState() => _CollegeEventsState();
}

final eventRef = FirebaseFirestore.instance.collection('events');

class _CollegeEventsState extends State<CollegeEvents> {
  User? user = FirebaseAuth.instance.currentUser;
  List<String> eventsId = [];
  EventModel addedEvent = EventModel();

  // @override
  // void initState() {
  //   super.initState();
  //   getEvents();
  //   // FirebaseFirestore.instance.collection("events").doc().get().then((value) {
  //   //   this.addedEvent = EventModel.fromMap(value.data());
  //   //   // print(addedEvent.collegeName);
  //   //   setState(() {});
  //   // });
  // }

  Future getEvents() async {
    return await eventRef
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // print(document.reference);
              eventsId.add(document.reference.id);
              // this.addedEvent = EventModel.fromMap(eventsId.data());
            }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.kWhite,
            )),
      ),
      backgroundColor: const Color.fromARGB(255, 4, 26, 45),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => AddEventScreen()));
        },
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // SizedBox(
                //   height: 50,
                // ),
                Container(
                  width: 200,
                  height: 70,
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
                      "COLLEGE EVENTS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "WhatsApp..",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //     color: Colors.blue,
                //   ),
                // ),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                child: Card(
                                  color: Color.fromARGB(255, 150, 216, 238),
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data!.docs[index]
                                                  .data()['collegeName'] !=
                                              null
                                          ? snapshot.data!.docs[index]
                                              .data()['collegeName']
                                          : "loading..",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    textColor: Color.fromARGB(255, 26, 13, 113),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            snapshot.data!.docs[index]
                                                        .data()['eventName'] !=
                                                    null
                                                ? snapshot.data!.docs[index]
                                                    .data()['eventName']
                                                : "loading..",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        Text(
                                            snapshot.data!.docs[index]
                                                        .data()['eventDate'] !=
                                                    null
                                                ? snapshot.data!.docs[index]
                                                    .data()['eventDate']
                                                : "loading..",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    isThreeLine: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ]),
    );
  }
}
