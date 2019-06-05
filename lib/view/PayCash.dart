import 'package:app1/controller/logic/Transfare.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';

import 'package:native_widgets/native_widgets.dart';

class PayCash extends StatefulWidget {
  PayCash(this.data);
  final List<User> data;
  _PayCashState createState() => _PayCashState(data);
}

class _PayCashState extends State<PayCash> {
  TextEditingController _amountController = TextEditingController();
  final List<User> data;
  List<String> names = List<String>();
  String selectedFrom ;
  String selectedTO ;

  void initState() {
    super.initState();
  }

  _PayCashState(this.data) {
    data.forEach((item) {
      String val = item.firstName + " " + item.lastName;
      int lenght = val.length;
      int limit = lenght >= 15 ? 15 : lenght;
      String add = val.substring(0, limit);
      names.add(add);
    });
    //selectedTO = names[1];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Text("Transfer Amount"),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          children: <Widget>[
            ListTile(
              leading: Text('From:'),
              title: DropdownButton<String>(
                items: names.map(
                  (String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  if (mounted)
                    setState(() {
                      selectedFrom = val;
                    });
                },
                value: selectedFrom,
              ),
            ),
            ListTile(
              leading: Text('Amount:'),
              title: TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                
              ),
            ),

            ListTile(
              leading: Text('To:'),
              title: DropdownButton<String>(
                items: names.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  if (mounted)
                    setState(() {
                      selectedTO = val;
                    });
                },
                value: selectedTO,
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
                  checkCancel();
                },
              ),
              title: NativeButton(
                  child: Text(
                    'OK',
                    //textScaleFactor: textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    checkOk();
                  }),
              
            ),

          ],
        ),
      ),
    );
  }

  void checkOk() {
    int from = names.indexOf(selectedFrom);
    int to = names.indexOf(selectedTO);

    if (!Support.checkValues(_amountController.text))
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('Enter the amont please!'),
          );
        },
      );
    else if (from == to) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('Cannot move to the same user!'),
          );
        },
      );
    } else {
      Transfare.transfare(
              data[from].id, data[to].id, int.parse(_amountController.text))
          .then((onValue) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (C) => DashboardMainPage()));

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Information"),
              content: new Text(
                  'the amount ${_amountController.text} has been transfer from :$selectedFrom to :$selectedTO successfully'),
            );
          },
        );
      });
    }
  }

  void checkCancel() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => DashboardMainPage()));
  }
}
