import 'package:app1/model/User.dart';
import 'package:app1/view/Order.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';



class ChooseToOrder extends StatefulWidget {
  final List<User> data;

  const ChooseToOrder(
    this.data, {
    Key key,
  }) : super(key: key);
  _ChooseToOrderState createState() => _ChooseToOrderState(this.data);
}

class _ChooseToOrderState extends State<ChooseToOrder> {
  final List<User> data;
  List<bool> checkData;
  _ChooseToOrderState(this.data) {
    print(data);
    int length = data.length;

    checkData = List(length);

    for (var i = 0; i < length; i++) {
      checkData[i] = (false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Users to Order"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (C, i) => listView(i),
              itemCount: data.length,
            ),
          ),
          ListTile(
              leading: RaisedButton(
                child: Text(
                    'Cancel',
                    //textScaleFactor: textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                color: Colors.redAccent[400],
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (C) => DashboardMainPage()));
                },
              ),
              title: RaisedButton(
                  child: Text(
                    'OK',
                    //textScaleFactor: textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: (){List<User> selected = List();
                    int selectedCount = 0;
                    int counter = 0;
                    data.forEach((user) {
                      if (checkData[counter]) {
                        selectedCount++;
                        selected.add(data[counter]);
                      }
                      counter++;
                    });
                    if (selectedCount < 2)
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Worning"),
                            content:
                                 Text('You must select at least two users'),
                          );
                        },
                      );
                    else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (C) => OrderPage(selected, selectedCount),
                        ),
                      );
                    }
                },),
              
            ),
        ],
      ),
      
    );
  }

  Widget listView(int index) {
    return Column(
      children: <Widget>[
        InkWell(
          child: ListTile(
            isThreeLine: false,
            enabled: true,
            //title: Text(data[index].username),
            title: Text(data[index].firstName + " " + data[index].lastName),
            trailing: Wrap(
              children: <Widget>[
                //Text("${data[index].amount.toStringAsFixed(2)}"),
                Checkbox(
                    value: checkData[index],
                    onChanged: (value) {
                      if (mounted)
                        setState(() {
                          checkData[index] = value;
                        });
                    })
              ],
            ),
          ),
          onTap: () {
            if (mounted)
              setState(() {
                if (checkData[index])
                  checkData[index] = false;
                else
                  checkData[index] = true;
              });
          },
        ),
        Divider()
      ],
    );
  }
}
