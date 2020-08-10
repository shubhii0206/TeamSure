import 'package:flutter/material.dart';
import 'package:hirer/services/auth.dart';
import 'input_decoration.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hirer/animation.dart';

class SignIn extends StatelessWidget {
  final _phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  final Function toogleView;
  final _loginKey = GlobalKey<FormState>();
  // final scaffoldKey = new GlobalKey<ScaffoldState>();

  SignIn({this.toogleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldKey,
        //resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            // child: new SingleChildScrollView(
            child: Form(
              key: _loginKey,
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue[300], Colors.white]),
                ),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)),
                          color: Colors.white,
                          image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage('assets/images/pic5.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: ((MediaQuery.of(context).size.width) - 300) / 2,
                        top: 320,
                        // left: -10,
                        // top: 200,
                        child: FadeAnimation(
                          1.0,
                          Container(
                            height: 370,
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
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 45,
                                ),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: 'PlayfairDisplay',
                                      color: Colors.blueAccent,
                                      fontSize: 44,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 270,
                                  height: 50,
                                  child: InputFormDeco(
                                    hintText: 'Phone Number',
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    validator: (value) => (value.length != 10)
                                        ? 'Enter a valid phone number'
                                        : null,
                                    controller: _phoneController,
                                  ),
                                ),
                                SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  width: 130,
                                  height: 55,
                                  child: Builder(
                                    builder: (context) => FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      color: Colors.blueAccent,
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Send OTP"),
                                      onPressed: () async {
                                        if (_loginKey.currentState.validate()) {
                                          // print(_phoneController.text.trim());
                                          final QuerySnapshot result =
                                              await Firestore.instance
                                                  .collection('Hirers')
                                                  .where('Phone Number',
                                                      isEqualTo:
                                                          _phoneController.text)
                                                  .limit(1)
                                                  .getDocuments();
                                          final List<DocumentSnapshot>
                                              documents = result.documents;
                                          if (documents.length == 1) {
                                            _authService.signInWithPhone(
                                                _phoneController.text.trim(),
                                                context);
                                          } else {
                                            print('no');
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text('Please Sign Up first!'),
                                              action: SnackBarAction(
                                                  label: 'OK',
                                                  onPressed:
                                                      Scaffold.of(context)
                                                          .hideCurrentSnackBar),
                                              elevation: 30,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: Duration(seconds: 15),
                                            ));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Don't have an account? ",
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                            child: Text("Sign Up Here",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue)),
                                            onTap: () {
                                              // do what you need to do when "Click here" gets clicked
                                              toogleView();
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
