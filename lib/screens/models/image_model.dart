class ImageModel {
  String? uid;
  String? profilePic;

  ImageModel({this.uid, this.profilePic});

  // receiving data from server
  factory ImageModel.fromMap(map) {
    return ImageModel(
      uid: map['uid'],
      profilePic: map['profilePic'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'profilePic': profilePic,
    };
  }
}
