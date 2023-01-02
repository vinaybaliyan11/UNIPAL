class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? profilePic;
  String? age;
  String? empType;
  String? currComp;
  List<String>? hobbies;
  List<String>? tech;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.profilePic,
    this.age,
    this.empType,
    this.currComp,
    this.hobbies,
    this.tech,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      profilePic: map['profilePic'],
      age: map['age'],
      currComp: map['currComp'],
      hobbies: map['hobbies'],
      tech: map['tech'],
      empType: map['empType'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'profilePic': profilePic,
      'age': age,
      'currComp': currComp,
      'hobbies': hobbies,
      'tech': tech,
      'empType': empType,
    };
  }
}
