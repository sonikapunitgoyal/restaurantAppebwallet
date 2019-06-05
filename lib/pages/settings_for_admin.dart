import 'package:flutter/material.dart';

import 'package:app1/utils/uidata.dart';
import 'package:app1/controller/dao/UserDAO.dart';
//import 'package:app1/main.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/AddAdmin.dart';
import 'package:app1/view/AddNewUser.dart';
import 'package:app1/view/AddResturant.dart';
import 'package:app1/view/RemoveUser.dart';
import 'package:app1/view/SetDataToZero.dart';
//import '../main.dart';
import 'package:app1/pages/report.dart';

import 'package:native_widgets/native_widgets.dart';



class SettingsAdminPage extends StatefulWidget {
  _SettingsAdminPageState createState() => _SettingsAdminPageState();
}

class _SettingsAdminPageState extends State<SettingsAdminPage> {
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

  Widget bodyData() => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Users Setting",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: Text("Add User"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => AddNewUser(),
                            ),
                          );
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      title: Text("Remove User"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => RemoveUser(data),
                            ),
                          );
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: Text("Add Administrator"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                       
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => AddAdmin(
                                    data: data,
                                  ),
                            ),
                          );
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        color: Colors.blue,
                      ),
                      title: Text("Add Restaurant"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => AddResturant(),
                            ),
                          );
                        
                      },
                    )
                  ],
                ),
              ),

              //2
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Reports",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.sim_card,
                        color: Colors.grey,
                      ),
                      title: Text("Reports"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        // // if (!myUser.admin)
                        // // //   checkAdmin();
                        // // else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => Report(),
                            ),
                          );
                        
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Administration",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.sync,
                        color: Colors.green,
                      ),
                      title: Text("Restore Database"),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (C) => RestoreFactory(),
                            ),
                          );
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.color_lens,
                        color: Colors.green,
                      ),
                      title: Text("Change theme Color"),
                      trailing: Switch(value: false,onChanged: (changedTheme){},),
                     
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
      title: Text("Settings"),
      ),
      body: bodyData(),
    );
  }
}
