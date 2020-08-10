import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractor/models/user.dart';

class DatabaseService {
  final User user;

  DatabaseService({this.user});

  //collection Reference
  final CollectionReference userCollection =
      Firestore.instance.collection('Contractors');

  Future updateUserData() async {
    print('Inside updateUserData');
    print(user.uid);
    print(user.name);
    print(user.address);
    print(user.mainArea);
    print(user.phoneNo);
    return await userCollection.document(user.uid).setData({
      'Name': user.name,
      'Phone Number': user.phoneNo,
      'Address': user.address,
      'Main Area': user.mainArea,
    });
  }
}
