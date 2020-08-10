import 'package:flutter/cupertino.dart';

class User {
  final String uid;
  String name, phoneNo, address, mainArea;

  User(
      {@required this.uid,
      this.address,
      this.mainArea,
      this.name,
      this.phoneNo});
}
