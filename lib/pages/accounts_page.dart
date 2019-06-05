import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:flutter/material.dart';

class AccountsPages extends StatefulWidget {
  AccountsPages({Key key}) : super(key: key);

  _AccountsPagesState createState() => _AccountsPagesState();
}

class _AccountsPagesState extends State<AccountsPages> {
  List<User> data = List();

  @override
  void initState() {
    inti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (c, i) => itemBuilder(i),
            itemCount: data.length,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          isThreeLine: false,
          enabled: true,
          title: Text(data[index].firstName + " " + data[index].lastName),
          trailing: Text("BD "+"${data[index].amount.toStringAsFixed(3)}"),
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
        Divider()
      ],
    );
  }

  void inti() async {
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
}
