import 'package:flutter/material.dart';
import 'package:hirer/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirer/animation.dart';
import 'package:hirer/sideDrawer.dart';
import 'package:hirer/screens/authenticate/input_decoration.dart';
import 'home.dart';

class Home1 extends StatefulWidget {
  @override
  _HomeState1 createState() => _HomeState1();
}

class _HomeState1 extends State<Home1> {
  final AuthService _authService = AuthService();
  //final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _numberController = TextEditingController();
  final _daysController = TextEditingController();

  final _moneyController = TextEditingController();
  final _locationController = TextEditingController();
  final _commentsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();

  final firestoreInstance = Firestore.instance;

  String _name = '';
  String _address = '';
  String _mainarea = '';
  String _phoneno = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

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
      // var _list = [];
      // value.data.forEach((k, v) => _list.add(v));

      setState(() {
        _name = value['Name'];
        _address = value['Address'];
        _mainarea = value['Main Area'];
        _phoneno = value['Phone Number'];
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
        title: Text('Hirer Home'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                _authService.phoneSignOut(context);
              },
              icon: Icon(Icons.person),
              label: Text('LOGOUT')),
        ],
      ),
      body: Center(
        child: Container(
            //constraints: BoxConstraints.expand(),
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage(
//                        // 'bg.jpg', Background image that will cover entire registration (signup) page
//                        ),
//                    fit: BoxFit.cover)),
            child: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: ((MediaQuery.of(context).size.width) - 350) / 2,
                  top: 35,
                  bottom: 35,
                  child: FadeAnimation(
                    1.5,
                    Container(
                      height: MediaQuery.of(context).size.height - 30,
                      width: 350,
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
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          controller: _scrollController,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Work Details",
                                style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    color: Color(0xff57c89f),
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              // InputFormDeco(
                              //   validator: (value) => (value.isEmpty)
                              //       ? 'Enter a valid name'
                              //       : null,
                              //   controller: _nameController,
                              //   hintText: 'Name of Hirer',
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              InputFormDeco(
                                validator: (value) => (value.isEmpty)
                                    ? 'Enter a valid work type'
                                    : null,
                                controller: _typeController,
                                hintText: 'Type of Work',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InputFormDeco(
                                keyboardType: TextInputType.multiline,
                                maxLines: 1,
                                validator: (value) => (value.isEmpty)
                                    ? 'Enter a valid number'
                                    : null,
                                controller: _numberController,
                                hintText: 'Number of Workers',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InputFormDeco(
                                validator: (value) => (value.isEmpty)
                                    ? 'Enter a valid work duration'
                                    : null,
                                controller: _daysController,
                                hintText: 'Number of Days',
                              ),
                              SizedBox(height: 20),
                              InputFormDeco(
                                keyboardType: TextInputType.multiline,
                                maxLines: 1,
                                validator: (value) => (value.isEmpty)
                                    ? 'Enter a valid amount'
                                    : null,
                                controller: _moneyController,
                                hintText: 'Amount in Rupees',
                              ),
                              SizedBox(height: 20),
                              InputFormDeco(
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                controller: _commentsController,
                                hintText: 'Any Commnets/Specifications',
                              ),
                              SizedBox(height: 20),
                              InputFormDeco(
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                validator: (value) => (value.isEmpty)
                                    ? 'Enter a valid Work Area'
                                    : null,
                                controller: _locationController,
                                hintText: 'Work Location',
                              ),
                              SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: RaisedButton(
                                  child: Text('Add Work'),
                                  color: Colors.green,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await firestoreInstance
                                          .collection('Work')
                                          .add({
                                        'Hirer name': _name,
                                        'Type of work':
                                            _typeController.text.trim(),
                                        'Number of workers':
                                            _numberController.text.trim(),
                                        'Amount': _moneyController.text.trim(),
                                        'Number of days':
                                            _daysController.text.trim(),
                                        'Comments': _commentsController == null
                                            ? 'None'
                                            : _commentsController.text.trim(),
                                        'Work Location':
                                            _locationController.text.trim(),
                                        'Hirer UID': user.uid,
                                        'Status': false,
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  child: Text("Go Back",
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
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    ));
  }
}
