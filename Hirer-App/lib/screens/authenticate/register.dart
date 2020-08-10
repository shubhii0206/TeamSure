import 'package:flutter/material.dart';
import 'package:hirer/models/user.dart';

import 'package:hirer/services/auth.dart';
import 'input_decoration.dart';

import 'package:hirer/animation.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mainAreaController = TextEditingController();
  final AuthService _authService = AuthService();
  ScrollController _scrollController = new ScrollController();

  final _formKey = GlobalKey<FormState>();

  // String dropdownValue;
  //AlertDialog fail = AlertDialog(title: Text("Enter Info correctly"));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        //key: _formKey,
        backgroundColor: Colors.green[50], //////
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/Labour.gif'))),
            // 'bg.jpg', Background image that will cover entire registration (signup) page
//                        ),
//                    fit: BoxFit.cover)),
            child: Form(
              key: _formKey,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: ((MediaQuery.of(context).size.width) - 300) / 2,
                      top: 130,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          height: 545,
                          width: 300,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              //background color of box
                              BoxShadow(
                                color: Colors.blueGrey[200],
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  10.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              bottomRight: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                              bottomLeft: const Radius.circular(40.0),
                              topLeft: const Radius.circular(40.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            controller: _scrollController,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "SignUp",
                                  style: TextStyle(
                                      fontFamily: 'PlayfairDisplay',
                                      color: Colors.green,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                InputFormDeco(
                                  validator: (value) => (value.length != 10)
                                      ? 'Enter a valid phone number'
                                      : null,
                                  controller: _phoneController,
                                  hintText: 'Phone Number',
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                InputFormDeco(
                                  validator: (value) => (value.isEmpty)
                                      ? 'Enter a valid name'
                                      : null,
                                  controller: _nameController,
                                  hintText: 'Name',
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                InputFormDeco(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  validator: (value) => (value.isEmpty)
                                      ? 'Enter a valid address'
                                      : null,
                                  controller: _addressController,
                                  hintText: 'Address',
                                ),
                                SizedBox(
                                  height: 16,
                                ),

                                // Container(
                                //   height: 48,
                                //   width: 270,
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: 13.0, horizontal: 20.0),
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(30),
                                //       color: Colors.grey[100],
                                //       border:
                                //           Border.all(color: Colors.grey[400])),
                                //   child: DropdownButtonHideUnderline(
                                //     child: DropdownButton<String>(
                                //       hint: dropdownValue == null
                                //           ? Text('Main Area')
                                //           : Text(
                                //               dropdownValue,
                                //               style: TextStyle(
                                //                   color: Colors.greenAccent),
                                //             ),
                                //       value: dropdownValue,
                                //       onChanged: (String newValue) {
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
                                //       ].map<DropdownMenuItem<String>>(
                                //           (String value) {
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
                                  validator: (value) => (value.length <= 0)
                                      ? 'Enter a valid main area'
                                      : null,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.grey[200])),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: Colors.grey[300])),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "Main Area"),
                                  controller: _mainAreaController,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 130,
                                  height: 45,
                                  child: FlatButton(
                                    child: Text("Sign Up"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        side: BorderSide(color: Colors.white)),
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    padding: EdgeInsets.all(8.0),
                                    onPressed: () {
                                      // print(_phoneController.text);
                                      // print(_nameController.text);
                                      // print(_addressController.text);
                                      // //print(_mainAreaController.text.trim());
                                      // print(dropdownValue);
                                      if (_formKey.currentState.validate()) {
                                        _authService.registerWithPhone(
                                            User(
                                              uid: '',
                                              name: _nameController.text.trim(),
                                              phoneNo:
                                                  _phoneController.text.trim(),
                                              address: _addressController.text
                                                  .trim(),
                                              mainArea: _mainAreaController.text
                                                  .trim(),
                                              // mainArea: dropdownValue.trim(),
                                            ),
                                            _formKey.currentContext);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Already have an account? ",
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                            child: Text("Login Here",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.green)),
                                            onTap: () {
                                              // do what you need to do when "Click here" gets clicked
                                              widget.toogleView();
                                            })
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
      onWillPop: () async {
        widget.toogleView();
        return false;
      },
    );
  }
}
