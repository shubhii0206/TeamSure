import 'package:flutter/material.dart';
import 'package:hirer/models/user.dart';
import 'package:hirer/screens/authenticate/authenticate.dart';
import 'package:hirer/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
