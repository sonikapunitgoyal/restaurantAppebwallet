import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';




class RemoveUser extends StatefulWidget {
  final List<User> data;
  RemoveUser(this.data, {Key key}) : super(key: key);

  _RemoveUserState createState() => _RemoveUserState(data);
}

class _RemoveUserState extends State<RemoveUser> {
  final List<User> data;
  List<bool> checkData;
  int length;
  _RemoveUserState(this.data) {
    length = data.length;
    checkData = List(length);
    int i = 0;
    data.forEach((a) {
      checkData[i++] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appTitle: "Remove User",
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Remove User"),),
      
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (C, i) => itemBuilder(i),
              itemCount: length,
            ),
          ),
          ListTile(
              leading: NativeButton(
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
              title: NativeButton(
                  child: Text(
                    'Remove user',
                    //textScaleFactor: textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: (){
                  List<User> selected = List();
                  int selectedCount = 0;
                  int counter = 0;
                  print(data.length);
                  print(checkData.length);
                  data.forEach((user) {
                    if (checkData[counter]) {
                      selectedCount++;
                      selected.add(data[counter]);
                    }
                    counter++;
                  });
                  if (selectedCount < 1)
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Worning"),
                          content: new Text("You must select at least 1"),
                        );
                      },
                    );
                  else {
                    selected.forEach((selected) {
                      if (selected.amount == 0) {
                        UserDAO().remove(selected.id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (C) => DashboardMainPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Worning"),
                              content: new Text(
                                  "Cannot delete user ${selected.firstName} amount not equal zero"),
                            );
                          },
                        );
                      }
                    });
                  }
                },),
              
            ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     RaisedButton(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(20))),
          //       child: Text(
          //         "cancel",
          //         style: TextStyle(color: Colors.blueAccent[700]),
          //       ),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (C) => DashboardMainPage()));
          //       },
          //     ),
          //     RaisedButton(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(20))),
          //       child: Text(
          //         "Remove",
          //         style: TextStyle(color: Colors.blueAccent[700]),
          //       ),
          //       onPressed: () {
          //         List<User> selected = List();
          //         int selectedCount = 0;
          //         int counter = 0;
          //         print(data.length);
          //         print(checkData.length);
          //         data.forEach((user) {
          //           if (checkData[counter]) {
          //             selectedCount++;
          //             selected.add(data[counter]);
          //           }
          //           counter++;
          //         });
          //         if (selectedCount < 1)
          //           showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 title: Text("Worning"),
          //                 content: new Text("You must select at least 1"),
          //               );
          //             },
          //           );
          //         else {
          //           selected.forEach((selected) {
          //             if (selected.amount == 0) {
          //               UserDAO().remove(selected.id);
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (C) => DashboardMainPage()));
          //             } else {
          //               showDialog(
          //                 context: context,
          //                 builder: (BuildContext context) {
          //                   return AlertDialog(
          //                     title: Text("Worning"),
          //                     content: new Text(
          //                         "Cannot delete user ${selected.firstName} amount not equal zero"),
          //                   );
          //                 },
          //               );
          //             }
          //           });
          //         }
          //       },
          //     ),
          //   ],
          // )
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
            Text("BD " + "${data[index].amount.toStringAsFixed(3)}"),
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
        leading: CircleAvatar(
          maxRadius: 25,
          child: Text(
            "" +
                data[index].firstName.substring(0, 1).toUpperCase() +
                data[index].lastName.substring(0, 1).toUpperCase(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        subtitle: Text(data[index].username),
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
    );
  }
}
