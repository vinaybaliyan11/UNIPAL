import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tinder_clone_app/screens/account_screen.dart';
import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
import 'package:flutter_tinder_clone_app/screens/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_clone_app/screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({Key? key}) : super(key: key);

  @override
  _AddInfoScreenState createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // string for displaying the error Message
  String? errorMessage;
  String? _empType;
  List<String> hobbiesList = [];
  List<String> techList = [];

  // editing Controller
  final ageEditingController = new TextEditingController();
  final currCompEditingController = new TextEditingController();
  final empTypeEditingController = new TextEditingController();
  final hobbiesEditingController = new TextfieldTagsController();
  final techEditingController = new TextfieldTagsController();

  @override
  void dispose() {
    // TODO: implement dispose
    ageEditingController.dispose();
    currCompEditingController.dispose();
    empTypeEditingController.dispose();
    hobbiesEditingController.dispose();
    techEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ageField = TextFormField(
        autofocus: false,
        controller: ageEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Age cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_month),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final currCompField = TextFormField(
        autofocus: false,
        controller: currCompEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Current Company cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          currCompEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.house),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Current Company",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //edit button
    final editChanges = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              try {
                postDetailsToFirestore();
              } catch (err) {
                Fluttertoast.showToast(msg: "Error occured");
              }
            }
          },
          child: Text(
            "Edit Changes",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    Widget _empTypefield() {
      var _options = [
        "Student",
        "Employed",
        "Unemployed",
      ];

      return FormField<String>(
        validator: (value) {
          if (value!.isEmpty) {
            return ("Employement type cannot be Empty");
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.work),
              hintText: 'Employement Type',
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            isEmpty: _empType == null || _empType == "",
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _empType,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    _empType = value;
                    state.didChange(value);
                  });
                },
                items: _options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
    }

    Widget hobbiesField() {
      return TextFieldTags(
        textfieldTagsController: hobbiesEditingController,
        textSeparators: const [' ', ','],
        letterCase: LetterCase.normal,
        validator: (String tag) {
         if (hobbiesEditingController.getTags!.contains(tag)) {
            return 'You already entered that';
          }
          return null;
        },
        inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(1, 5, 1, 5),
              child: TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  // helperText: 'Add hobbies...',
                  helperStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                  hintText:
                      hobbiesEditingController.hasTags ? '' : "Hobbies",
                  errorText: error,
                  // prefixIconConstraints:
                  //     BoxConstraints(maxWidth: _distanceToField * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: tags.map((String tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: Colors.blue,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '$tag',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      hobbiesList.add(tag);
                                      print("$hobbiesList");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      hobbiesList.remove(tag);
                                      onTagDelete(tag);

                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList()),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              ),
            );
          });
        },
      );
    }

    Widget techField() {
      return TextFieldTags(
        textfieldTagsController: techEditingController,
        textSeparators: const [' ', ','],
        letterCase: LetterCase.normal,
        validator: (String tag) {
       if (techEditingController.getTags!.contains(tag)) {
            return 'You already entered that';
          }
          return null;
        },
        inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
          return ((context, sc, tags, onTagDelete) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(1, 5, 1, 15),
              // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  // helperText: 'Add tech stack...',
                  helperStyle: const TextStyle(
                    color: Colors.blue,
                  ),
                  hintText: techEditingController.hasTags ? '' : "Technologies",
                  errorText: error,
                  // prefixIconConstraints:
                  //     BoxConstraints(maxWidth: _distanceToField * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: tags.map((String tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: Colors.blue,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Text(
                                      '$tag',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      techList.add(tag);
                                      print("$techList");
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14.0,
                                      color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      techList.remove(tag);
                                      onTagDelete(tag);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList()),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              ),
              
            );
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Info",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ageField,
                    SizedBox(height: 20),
                    _empTypefield(),
                    SizedBox(height: 20),
                    currCompField,
                    SizedBox(height: 20),
                    hobbiesField(),
                    SizedBox(height: 20),
                    techField(),
                    SizedBox(height: 20),
                    editChanges,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.age = ageEditingController.text;
    userModel.empType = _empType;
    userModel.currComp = currCompEditingController.text;
    userModel.hobbies = hobbiesList;
    userModel.tech = techList;

    CollectionReference collection =
        FirebaseFirestore.instance.collection("users");
    DocumentReference document = collection.doc(user!.uid);
    document.update({
      "age": userModel.age,
      "empType": userModel.empType,
      "currComp": userModel.currComp,
      "hobbies": userModel.hobbies,
      "tech": userModel.tech,
    });

    Navigator.pop(context);
  }
}
