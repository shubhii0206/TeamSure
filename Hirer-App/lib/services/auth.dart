import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirer/models/user.dart';
import 'package:hirer/screens/home/home.dart';
import 'package:hirer/screens/wrapper.dart';
import 'package:hirer/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _codeController = TextEditingController();

  //Create a new User Object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return (user != null) ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future registerUser(
    String phone,
    BuildContext context, {
    String name = '',
    String address = '',
    String mainArea = '',
    String phoneNo = '',
  }) async {
    _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) {
          //Navigator.pop(context);
          print('In verificationCompleted');
          _auth
              .signInWithCredential(credential)
              .then((AuthResult result) async {
            print('Uid: ' + result.user.uid);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
            if (name != '' &&
                address != '' &&
                mainArea != '' &&
                phoneNo != '') {
              await DatabaseService(
                user: User(
                    uid: result.user.uid,
                    phoneNo: phone,
                    name: name,
                    address: address,
                    mainArea: mainArea),
              ).updateUserData();
            }
          }).catchError((e) => print(e));
        },
        verificationFailed: (AuthException exception) {
          print('In verificationFailed');
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          print('In codeSent');
          print(phone);
          print(name);
          print(address);
          print(mainArea);

          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (contextDialog) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    height: 250,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter OTP',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            // autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: '* * * * * *',
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            controller: _codeController,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 300.0,
                            child: RaisedButton(
                              onPressed: () async {
                                var _credential =
                                    PhoneAuthProvider.getCredential(
                                        verificationId: verificationId,
                                        smsCode: _codeController.text.trim());
                                _auth
                                    .signInWithCredential(_credential)
                                    .then((AuthResult result) async {
                                  print('Uid:' + result.user.uid);

                                  if (name != '' &&
                                      address != '' &&
                                      mainArea != '' &&
                                      phoneNo != '') {
                                    await DatabaseService(
                                      user: User(
                                          uid: result.user.uid,
                                          name: name,
                                          address: address,
                                          mainArea: mainArea,
                                          phoneNo: phone),
                                    ).updateUserData();
                                    Navigator.of(contextDialog).pop();
                                  }
                                  // Navigator.of(context).pop();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                }).catchError((e) {
                                  print(e);
                                });
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0xff57c89f),
                            ),
                          )
                        ],
                      ),
                    ),
                  )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('In codeAutoRetrievalTimeout');
          verificationId = verificationId;
          print(verificationId);
          print('TimeOut');
        });
  }

  //sign in
  signInWithPhone(String phone, BuildContext context) {
    registerUser(phone, context);
  }

  //register - only if the user the a user isn't created yet.
  registerWithPhone(User user, BuildContext context) {
    print('In registerWithPhone');
    print(user.uid);
    print(user.name);
    print(user.address);
    print(user.mainArea);
    print(user.phoneNo);
    registerUser(user.phoneNo, context,
        name: user.name,
        address: user.address,
        mainArea: user.mainArea,
        phoneNo: user.phoneNo);
  }

  //sign out
  Future phoneSignOut(BuildContext context) async {
    print('Inside Sign Out');
    try {
      print(user);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
      return _auth.signOut();
    } catch (err) {
      print('Sign Out Error');
      print(err.toString());
      return null;
    }
  }
}
