import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCollegeName extends StatelessWidget {
  final String documentId;

  GetCollegeName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              '${data['collegeName']}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, ),
            );
          }
          return Text('loading..');
        }));
  }
}

class GetEventName extends StatelessWidget {
  final String documentId;

  GetEventName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['eventName']}',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, ),);
          }
          return Text('loading..');
        }));
  }
}

class GetEventDate extends StatelessWidget {
  final String documentId;

  GetEventDate({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['eventDate']}' ,  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, ),);
          }
          return Text('loading..');
        }));
  }
}
