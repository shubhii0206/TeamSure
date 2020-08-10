import 'dart:async';

import 'package:flutter/material.dart';
import 'package:contractor/models/user.dart';

import 'package:contractor/screens/wrapper.dart';
import 'package:contractor/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:contractor/screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => Home(),
        },
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Wrapper())));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xffffffff),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 180,
                  left: (MediaQuery.of(context).size.width - 90) / 2,
                  child: Image.asset(
                    'assets/images/loader.gif',
                    height: 90,
                    width: 90,
                  ),
                ),
                Positioned(
                  top: 220,
                  left: (MediaQuery.of(context).size.width - 90) / 2,
                  child: SizedBox(
                    child: Text('SPLASH PAGE'),
                    height: 90,
                    width: 90,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
