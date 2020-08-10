import 'package:flutter/material.dart';
import 'package:contractor/screens/authenticate/register.dart';
import 'package:contractor/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toogleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (showSignIn)
          ? SignIn(toogleView: toogleView)
          : Register(toogleView: toogleView),
    );
  }
}
