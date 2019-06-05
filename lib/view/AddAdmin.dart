import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class AddAdmin extends StatefulWidget {
  final List<User> data;

  const AddAdmin({Key key, this.data}) : super(key: key);
  @override
  _AddAdminState createState() => _AddAdminState(data);
}

class _AddAdminState extends State<AddAdmin> {
  _AddAdminState(this.data);
  final List<User> data;
  List<User> nonAdmin = List();

  // @override
  // void initState() {
  //   inti();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Administrator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (C, i) => itemBuilder(i),
              itemCount: data.length,
            ),
          ),
          ListTile(
            leading: NativeButton(
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              color: Colors.redAccent[400],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (C) => DashboardMainPage()));
              },
            ),
            title: NativeButton(
                child: Text(
                  'Add admin',
//textScaleFactor: textScaleFactor,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  print(nonAdmin.length);
                  print(data.length);

                  UserDAO dao = UserDAO();
                  for (var i = 0; i < data.length; i++) {
                    dao.setAdmin(data[i]);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (C) => DashboardMainPage()));
                }),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(int index) {
    return InkWell(
      child: ListTile(
        isThreeLine: false,
        enabled: true,
title: Text(data[index].firstName + " " + data[index].lastName),
        trailing: Wrap(
          children: <Widget>[
// Text("${data[index].amount.toStringAsFixed(2)}"),
            Checkbox(
                value: data[index].admin,
                onChanged: (value) {
                  if (mounted)
                    setState(() {
                      data[index].admin = true;
                    });
                })
          ],
        ),
        leading: CircleAvatar(
          maxRadius: 25,
          child: Text(
            "" +
                data[index].firstName.substring(0, 1).toUpperCase() +
               data[index].lastName.substring(0, 1).toUpperCase(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      onTap: () {
        if (mounted)
          setState(() {
            if (data[index].admin)
             data[index].admin = false;
            else
              data[index].admin = true;
          });
      },
    );
  }

  // void inti() async {
  //   UserDAO().getAllUsers().then((onValue) {
  //     onValue.documents.forEach((doc) {
  //       if (mounted)
  //         setState(() {
  //           nonAdmin.add(
  //             User.fromDocument(doc),
  //           );
  //         });
  //     });
  //   });
  // }
}
