import 'package:app1/controller/dao/ResturantDAO.dart';
// import 'package:app1/main.dart';
import 'package:app1/model/Resturant.dart';
// import 'package:app1/view/AddAdmin.dart';
// import 'package:app1/view/AddNewUser.dart';
// import 'package:app1/view/AddResturant.dart';
// import 'package:app1/view/ChooseToOrder.dart';
// import 'package:app1/view/RemoveUser.dart';
//import 'package:app1/view/Report.dart';
// import 'package:app1/view/SetDataToZero.dart';
import 'package:flutter/material.dart';
// import 'package:app1/view/PayCash.dart';

class ResturantsPages extends StatefulWidget {
  ResturantsPages({Key key}) : super(key: key);

  _ResturantsPagesState createState() => _ResturantsPagesState();
}

class _ResturantsPagesState extends State<ResturantsPages> {
  List<Resturant> data = List();

  @override
  void initState() {
    inti();
    super.initState();
  }

/////////////////////////////////////////
  // final makeCard = Card(
  //   elevation: 8.0,
  //   margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  //   child: Container(
  //     decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
  //     child: makeListTile,
  //   ),
  // );

  // final makeBody = Container(
  //   child: ListView.builder(
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     itemCount: 10,
  //     itemBuilder: (BuildContext context, int index) {
  //       return makeCard;
  //     },
  //   ),
  // );

////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            // scrollDirection: Axis.vertical,
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
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          // leading: Container(
          //   padding: EdgeInsets.only(right: 12.0),
          //   decoration: new BoxDecoration(
          //       border: new Border(
          //           right: new BorderSide(width: 1.0, color: Colors.white24))),
          //   child: Icon(Icons.autorenew, color: Colors.grey),
          // ),
          isThreeLine: false,
          enabled: true,
          title: Text(
            data[index].name,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          subtitle: Text(
            data[index].telephone,
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),

          //  Row(
          //   children: <Widget>[
          //     Icon(Icons.restaurant_menu, color: Colors.grey),
          //     Text(
          //       " Menu",
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //   ],
          // ),
          trailing: Container(
            //color: Colors.amber.shade400,
            //padding: EdgeInsets.only(right: 12.0),
            
            decoration: new BoxDecoration(
              //color: Colors.blue.shade100,
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
            child: Icon(Icons.restaurant_menu, color: Colors.grey),
            // Text(
            //   " Menu",
            //   style: TextStyle(color: Colors.grey),
            // ),

            //child: Icon(Icons.autorenew, color: Colors.grey),
          ),
          // trailing: Text(
          //   data[index].telephone,
          //   style: TextStyle(fontSize: 20.0, color: Colors.grey),
          // ),
        ),
        Divider()
      ],
    );
  }

  void inti() async {
    ResturantDAO().getAllResturants().then((onValue) {
      onValue.documents.forEach((doc) {
        if (mounted)
          setState(() {
            data.add(
              Resturant.fromDocument(doc),
            );
          });
      });
    });
  }
}
