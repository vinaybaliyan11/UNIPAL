class EventModel {
  
  String? eventId;
  String? uid;
  String? collegeName;
  String? eventName;
  String? date;
  EventModel({ this.eventId, this.collegeName, this.eventName, this.date, this.uid});

  // receiving data from server
  factory EventModel.fromMap(map) {
    return EventModel(
      eventId: map['eventId'],
      uid: map['uid'],
      collegeName: map['collegeName'],
      eventName: map['eventName'],
      date : map['eventDate']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'uid': uid,
      'eventName': eventName,
      'collegeName': collegeName,
      'eventDate': date
    };
  }
}
