import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/model/Resturant.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:app1/view/Support.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

class AddResturant extends StatefulWidget {
  AddResturant({Key key}) : super(key: key);

  _AddResturantState createState() => _AddResturantState();
}

class _AddResturantState extends State<AddResturant> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();

 // bool _isAdmin = false;

  //TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
        elevation: 0,
        title: Text("Add New Restaurant "),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: 7,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Restaurant Name",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                //border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            TextField(
              controller: _telephoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Telephone No.",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              child: Text(
                "Add",
                  style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
              onPressed: () {
                checkValues();
              },
            ),
            
          ],
        ),
      ),
    );
  }

  bool hasValue(String val) {
    return (!(val == null || val.trim() == ""));
  }

 checkValues() {
    if (!Support.checkValues((_nameController.text)))
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('Enter the restautant name'),
          );
        },
      );
    else if (!Support.checkValues(_telephoneController.text))
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('Enter the telephone No.'),
          );
        },
      );
    else {
      ResturantDAO()
          .saveResturant(
              resturant: Resturant(
                  name: _nameController.text,
                  telephone: _telephoneController.text))
          .get()
          .then((onValue) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Information"),
              content: new Text('The new restaurant has been added'),
            );
          },
        ).then((onValue) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
        });
      });
    }
  }
}
