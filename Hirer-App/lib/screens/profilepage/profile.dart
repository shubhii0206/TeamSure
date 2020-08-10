import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hirer/screens/authenticate/input_decoration.dart';
import 'package:hirer/screens/home/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  final String name;
  final String address;
  final String mainarea;
  final String phoneno;

  @override
  _ProfileState createState() => _ProfileState();
  Profile(
      {@required this.name,
      @required this.address,
      @required this.mainarea,
      @required this.phoneno});
}

class _ProfileState extends State<Profile> {
  //final AuthService _authService = AuthService();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mainAreaController = TextEditingController();
  //String dropdownValue;

  final firestoreInstance = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String finalname;
  String finaladdress;
  AlertDialog success = AlertDialog(title: Text("Changes Successful!"));

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('PROFILE', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.green[300],
        elevation: 0.0,
        // actions: <Widget>[
        //   FlatButton.icon(
        //       onPressed: () async {
        //         _authService.phoneSignOut(context);
        //       },
        //       icon: Icon(Icons.person),
        //       label: Text('LOGOUT')),
        // ],
      ),
      body: Form(
        child: Center(
          child: Container(
            height: 545,
            width: 300,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Color(0xff57c89f),
                      fontSize: 34,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 45,
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) =>
                      (value.length < 10) ? 'Enter a valid phone number' : null,
                  controller: _phoneController..text = widget.phoneno,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[350],
                    hintText: 'Phone Number',
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 20.0),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                ),
                // InputFormDeco(
                //   validator: (value) =>
                //       (value.length < 10) ? 'Enter a valid phone number' : null,
                //   controller: _phoneController..text = widget.phoneno,
                //   hintText: 'Phone Number',
                //   maxLines: 1,
                //   keyboardType: TextInputType.number,
                // ),
                SizedBox(
                  height: 16,
                ),
                InputFormDeco(
                  validator: (value) =>
                      (value.length <= 0) ? 'Enter a valid name' : null,
                  controller: _nameController..text = widget.name,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: 16,
                ),
                InputFormDeco(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) =>
                      (value.length <= 0) ? 'Enter a valid address' : null,
                  controller: _addressController..text = widget.address,
                  hintText: 'Address',
                ),
                SizedBox(
                  height: 16,
                ),

                // Container(
                //   height: 48,
                //   width: 270,
                //   padding:
                //       EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: Colors.grey[100],
                //       border: Border.all(color: Colors.grey[400])),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       hint: dropdownValue == null
                //           ? Text(widget.mainarea)
                //           : Text(
                //               dropdownValue,
                //               style: TextStyle(color: Colors.blue),
                //             ),
                //       value: dropdownValue,
                //       onChanged: (String newValue) {
                //         finalname = _nameController.text;
                //         finaladdress = _addressController.text;
                //         setState(() {
                //           dropdownValue = newValue;
                //         });
                //       },
                //       items: <String>[
                //         'Area1',
                //         'Area2',
                //         'Area3',
                //         'Area4',
                //         'Area5',
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),

                // If main area should be text input instead of dropdown, use the following code:

                TextFormField(
                  validator: (value) =>
                      (value.length <= 0) ? 'Enter a valid main area' : null,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Main Area"),
                  controller: _mainAreaController..text = widget.mainarea,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 130,
                  height: 45,
                  child: FlatButton(
                    child: Text("Save Changes"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        side: BorderSide(color: Colors.white)),
                    color: Color(0xff57c89f),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () async {
                      user = await _auth.currentUser();
                      firestoreInstance
                          .collection("Hirers")
                          .document(user.uid)
                          .setData({
                        'Name': _nameController.text,
                        'Address': _addressController.text,
                        'Main Area': _mainAreaController.text,
                      }, merge: true).then((_) {
                        print('success');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return success;
                          },
                        );
                        Timer(
                            Duration(seconds: 1),
                            () => {
                                  Navigator.of(context).pop(),
                                  Navigator.of(context).pop(),
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Home()))
                                });
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                GestureDetector(
                    child: Text("No Changes...Go Back",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
