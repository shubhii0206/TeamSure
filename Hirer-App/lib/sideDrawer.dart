import 'package:flutter/material.dart';
import 'package:hirer/screens/profilepage/profile.dart';
import 'package:hirer/screens/wrapper.dart';
import 'package:hirer/services/auth.dart';

class SideDrawer extends StatefulWidget {
  final String name;
  final String address;
  final String mainarea;
  final String phoneno;

  @override
  _SideDrawerState createState() => _SideDrawerState();
  SideDrawer(
      {@required this.name,
      @required this.address,
      @required this.mainarea,
      @required this.phoneno});
}

class _SideDrawerState extends State<SideDrawer> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green[50],
// ==========Whole Drawer====================
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
// ============== Header =======================
            new UserAccountsDrawerHeader(
              accountName: Text(
                widget.name,
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              accountEmail: Text(
                widget.phoneno,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 45.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green[400],
              ),
            ),

// ================= Drawer Options ======================

            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              trailing: Icon(Icons.person),
              onTap: () {
                print('Inside item1');
                print(widget.name);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Profile(
                          name: widget.name,
                          address: widget.address,
                          phoneno: widget.phoneno,
                          mainarea: widget.mainarea,
                        )));
              },
            ),

            Divider(
              color: Colors.black,
              thickness: 1,
              height: 16,
            ),

            Align(
              alignment: Alignment.topLeft,
              heightFactor: 28.0,
              widthFactor: 72.0,
              child: Container(
                margin: const EdgeInsets.only(left: 32.0, top: 16.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(width: 2.0, color: Colors.black),
                    ),
                    splashColor: Colors.greenAccent,
                    color: Colors.green[300],
                    onPressed: () async {
                      _authService.phoneSignOut(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    },
                    child: Text(
                      'SIGN OUT',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
