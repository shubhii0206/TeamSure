import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkData extends StatefulWidget {
  Map work;

  String workID;
  String c_name;
  String c_number;

  String c_id;

  @override
  _WorkDataState createState() => _WorkDataState();
  WorkData({
    @required this.work,
    @required this.workID,
    @required this.c_name,
    @required this.c_id,
    @required this.c_number,
  });
}

class _WorkDataState extends State<WorkData> {
  final _amountController = TextEditingController();
  final firestoreInstance = Firestore.instance;
  AlertDialog done = AlertDialog(title: Text("Done!"));

  @override
  Widget build(BuildContext context) {
    print(widget.work);
    return Scaffold(
        //backgroundColor: Colors.red[500],
        body: Container(
      constraints: BoxConstraints.expand(),

      margin: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25.0),
      //   gradient: LinearGradient(
      //       begin: Alignment.topRight,
      //       end: Alignment.bottomLeft,
      //       colors: [Colors.blueGrey[900], Colors.brown[100]]),

      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(25),
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text(
                  'Hirer name: ${widget.work['Hirer name']}',
                  style: TextStyle(fontSize: 17),
                ),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Type of work: ${widget.work['Type of work']}',
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Work Location: ${widget.work['Work Location']}',
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Number of Days: ${widget.work['Number of days']}',
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Number of workers: ${widget.work['Number of workers']}',
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Amount: ${widget.work['Amount']}',
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                Text('Comments/Suggestions: ${widget.work['Comments']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(fontSize: 17)),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'How much amount would you like to propose for this work? Please enter the value here :',
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      controller: _amountController..text,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: 'Amount in Rupees',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                    FlatButton(
                        child: Text("Propose this Amount"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            side: BorderSide(color: Colors.white)),
                        color: Color(0xff57c89f),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          firestoreInstance
                              .collection("Work")
                              .document(widget.workID)
                              .updateData({
                            widget.c_id: [
                              widget.c_name,
                              _amountController.text,
                              widget.c_number
                            ],
                          }).then((_) {
                            print("success!");
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return done;
                              },
                            );
                          });

                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        child: Text("Go back"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            side: BorderSide(color: Colors.grey)),
                        color: Colors.white,
                        textColor: Color(0xff57c89f),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
