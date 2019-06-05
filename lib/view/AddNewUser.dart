import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:app1/utils/uidata.dart';
import 'package:native_widgets/native_widgets.dart';
class AddNewUser extends StatefulWidget {
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add New User"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              //keyboardType: TextInputType.numberWithOptions(decimal: true),
              //maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _lastNameController,
              //keyboardType: TextInputType.numberWithOptions(decimal: true),
              //maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.number,
              //maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _passwordController,
              //keyboardType: TextInputType.numberWithOptions(decimal: true),
              //maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              //maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              //onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                // border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Checkbox(
                value: _isAdmin,
                onChanged: (a) {
                  if (mounted)
                    setState(() {
                      _isAdmin = a;
                    });
                },
              ),
              title: Text(
                "Administrator",
                style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
              ),
            ),
            RaisedButton(
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  checkValues();
                })
          ],
        ),
      ),
    );
  }

  bool hasValue(String val) {
    return (!(val == null || val.trim() == ""));
  }

   checkValues() {
    if (!Support.checkValues((_firstNameController.text)))
      
      {
        var alert= AlertDialog(
          title: Text("Enter firstname"),
          actions: <Widget>[Icon(Icons.error)],
        );
        showDialog(
        
        context: context,builder: (_) => alert
      );}
    else if (!Support.checkValues(_lastNameController.text))
     
     {
       var alert= AlertDialog(
          title: Text("Enter lastname"),
          actions: <Widget>[Icon(Icons.error)],
        );
        showDialog(
       
        context: context,builder: (_) => alert
      );}
    else if (!Support.checkValues(_usernameController.text)){
      var  alert= AlertDialog(
          title: Text("Enter username"),
          actions: <Widget>[Icon(Icons.error)],
        );
      showDialog(
      
        context: context,  builder: (_) => alert
      );}
    else if (!Support.checkValues(_passwordController.text))
    {
    var alert=  AlertDialog(
          title: Text("Enter password"),
          actions: <Widget>[Icon(Icons.error)],
        );
      showDialog(
       
        context: context,  builder: (_) => alert
      );}
    else if (!Support.checkValues(_emailController.text))
      {
        var alert= AlertDialog(
          title: Text("Enter Email"),
          actions: <Widget>[Icon(Icons.error)],
        );
      showDialog(
        
        context: context,  builder: (_) => alert
      );}
    else {
      UserDAO()
          .saveUser(
              user: User(
                admin: _isAdmin,
                  amount: 0,
                  firstName: _firstNameController.text,
                  username: _usernameController.text,
                  lastName: _lastNameController.text,
                  pass: _passwordController.text))
          .then((onValue) { var alert=AlertDialog(
              title: Text(
            "User Added",
          ));
        showDialog(context: context, builder: (_) => alert);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
      });
    }
  }
}
