import 'package:flutter/material.dart';
import 'package:app1/controller/dao/Local.dart';
import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/main.dart';
//import 'package:app1/pages/root_page.dart';

import 'package:app1/model/User.dart';


//import 'package:app1/view/Report.dart';
import 'package:app1/pages/settings_for_admin.dart';

import 'package:app1/view/PayCash.dart';
import 'package:app1/view/ChooseToOrder.dart';


import 'package:app1/pages/report.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<User> data;
  @override
  void initState() {
    data = List();
    inti();
    super.initState();
  }

  void inti() async {
    data = null;
    data = List();
    UserDAO().getAllUsers().then((onValue) {
      onValue.documents.forEach((doc) {
        if (mounted)
          setState(() {
            data.add(
              User.fromDocument(doc),
            );
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0,),
            SizedBox(
              height: 100.0,
              child: Image.asset('assets/logo.png'),
            ),
            Divider(),
            // AppBar(
            //   automaticallyImplyLeading: false,
            //   title: Text('Choose'),
            // ),
            ListTile(
              leading: Icon(Icons.compare_arrows),
              title: Text('Transfer Money'),
              onTap: () {
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => PayCash(data),
                    ),
                  );
                
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Report'),
              onTap: () {
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => Report(),
                    ),
                  );
                
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Order'),
              onTap: () {
                // if (!myUser.admin)
                //   checkAdmin();
                // else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (C) => ChooseToOrder(data),
                    ),
                  );
                // }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              title: Text('Settings'),
              onTap: () {
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (C) => SettingsAdminPage(),
                    ),
                  );
                
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Logout'),
              onTap: () {
                Local()
                    .deleteUser(
                        myUser.id) //her we removed from local database sqlite
                    .then((onValue) {
                  if (onValue == 1) {
                    myUser =
                        null; //her we set the value of exist user to null ok?
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (C) => MyApp(false)));
                  } else { var alert =  AlertDialog(title: Text("still login"));
                   showDialog(context: context, builder: (_) => alert);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkAdmin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Access Denied"),
          content: new Text('Admin rights required!'),
        );
      },
    );
  }
}
