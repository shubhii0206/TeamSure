import 'package:flutter/material.dart';

import 'package:hirer/screens/wrapper.dart';
import 'package:hirer/services/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_work.dart';
import 'package:hirer/sideDrawer.dart';
import 'display.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  final firestoreInstance = Firestore.instance;
  String _uid = '';
  String _name = '';
  String _address = '';
  String _mainarea = '';
  String _phoneno = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Widget buildWorkList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot work = snapshot.data.documents[index];
          String workID = work.documentID;

          return Card(
              child: Container(
                  height: 100,
                  child: ListTile(
                    // Access the fields as defined in FireStore
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.build),
                        SizedBox(
                          width:
                              5, // here put the desired space between the icon and the text
                        ),
                        Text(
                          'Type of work: ${work.data['Type of work']}',
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ), // here we could use a column widget if we want to add a subtitle
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    subtitle: Text(
                      'Proposed Amount: ${work.data['Amount']}',
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Display(work: work.data, id: workID)),
                      );
                    },
                  )));
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No users found."),
      );
    } else {
      // Still loading
      return Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    firestoreInstance
        .collection("Hirers")
        .document(user.uid)
        .get()
        .then((value) {
      print(value.data);

      setState(() {
        _name = value['Name'];
        _address = value['Address'];
        _mainarea = value['Main Area'];
        _phoneno = value['Phone Number'];
        _uid = user.uid;
      });
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('from Home page');
    // print('$name, $address, $mainarea, $phoneno');
    return Container(
        child: Scaffold(
            backgroundColor: Colors.green[50],
            drawer: SideDrawer(
              name: _name,
              address: _address,
              mainarea: _mainarea,
              phoneno: _phoneno,
            ),
            appBar: AppBar(
              title: Text("Namaste " + _name),
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      _authService.phoneSignOut(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Wrapper()));
                    },
                    icon: Icon(Icons.person),
                    label: Text('LOGOUT')),
              ],
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 250,
                  child: FutureBuilder(
                      builder: buildWorkList,
                      future: Firestore.instance
                          .collection('Work')
                          .where("Hirer UID", isEqualTo: _uid)
                          .getDocuments()),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 60,
                  width: 200,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RaisedButton(
                          child: Text('Add Work'),
                          color: Colors.green,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home1()),
                            );
                          })),
                )
              ],
            )));
  }
}
