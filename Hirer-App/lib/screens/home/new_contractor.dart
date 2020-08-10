import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContractWork extends StatefulWidget {
  Map work;
  String id;

  @override
  _ContractWorkState createState() => _ContractWorkState();
  ContractWork({@required this.work, @required this.id});
}

class _ContractWorkState extends State<ContractWork> {
  Map contractors;

  @override
  Widget build(BuildContext context) {
    contractors = widget.work;
    contractors.remove('Work Location');
    contractors.remove('Type of work');
    contractors.remove('Number of days');
    contractors.remove('Number of workers');
    contractors.remove('Amount');
    contractors.remove('Status');
    contractors.remove('Hirer name');
    contractors.remove('Hirer UID');
    contractors.remove('Comments');

    return Scaffold(
      appBar: AppBar(
        title: Text("Contractors"),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
//            Expanded(
//                child: new ListView.builder(
//              itemCount: contractors.length,
//              itemBuilder: (BuildContext context, int index) {
//                String key = contractors.keys.elementAt(index);
//                return new Column(
//                  children: <Widget>[
//                  new SizedBox(height: 100),
//                    //new Text('$key : '),
//                    new Text(contractors[key][0]),
//                    new Text(contractors[key][1]),
//                    new Text(contractors[key][2])
//                  ],
//                );
//              },
//            )),

            Expanded(
                child: new ListView.builder(
              itemCount: contractors.length,
              itemBuilder: (BuildContext context, int index) {
                String key = contractors.keys.elementAt(index);
                return new Card(
                  elevation: 10,
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.greenAccent[100],
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.build,
                                size: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: new Text(
                                  contractors[key][0],
                                  style: TextStyle(
                                    fontFamily: 'Lora',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    // wordSpacing: 4,
                                  ),
                                  // here we could use a column widget if we want to add a subtitle
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            color: Colors.green[400],
                            alignment: Alignment.center,
                            height: 90,
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  new Text(
                                    'Contact No: ',
                                    style: TextStyle(
                                      fontFamily: 'Lora',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ), // here we could use a column widget if we want to add a subtitle
                                  ),
                                  new Text(
                                    contractors[key][2],
                                    style: TextStyle(
                                      fontFamily: 'Lora',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ), // here we could use a column widget if we want to add a subtitle
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  new Text(
                                    'Proposed Price: ',
                                    style: TextStyle(
                                      fontFamily: 'Lora',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ), // here we could use a column widget if we want to add a subtitle
                                  ),
                                  new Text(
                                    contractors[key][1],
                                    style: TextStyle(
                                      fontFamily: 'Lora',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ), // here we could use a column widget if we want to add a subtitle
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            )),

            Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: RaisedButton(
                    child: Text('Back'),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
          ],
        ),
      ),
    );
  }
}
