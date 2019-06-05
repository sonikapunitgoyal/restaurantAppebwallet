import 'package:flutter/material.dart';
//import 'package:app1/controller/dao/Local.dart';
import 'package:app1/controller/dao/UserDAO.dart';
//import 'package:app1/main.dart';
//import 'package:app1/pages/root_page.dart';
//import 'package:app1/model/Constants.dart';
import 'package:app1/model/User.dart';
import 'package:app1/model/app_drawer.dart';
import 'package:app1/view/ChooseToOrder.dart';
//import 'package:app1/view/Report.dart';
//import 'package:app1/pages/settings_for_user.dart';
//import 'package:app1/pages/settings_for_admin.dart';

//import 'package:app1/view/PayCash.dart';
//import 'package:app1/utils/uidata.dart';
import 'package:app1/pages/accounts_page.dart';
//import 'package:app1/pages/accounts_page.dart' as accountPage;


import 'package:app1/pages/resturants_page.dart';
//import 'package:app1/pages/resturants_page.dart' as restaurantPage;



class DashboardMainPage extends StatefulWidget {
  _DashboardMainPageState createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends State<DashboardMainPage> {
  List<User> data;
  @override
  void initState() {
    data = List();
    inti();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        // bottomNavigationBar: BottomAppBar(
        //   clipBehavior: Clip.antiAlias,
        //   shape: CircularNotchedRectangle(),
        //   child: Ink(
        //     height: 50.0,
        //     decoration: new BoxDecoration(
        //         gradient: new LinearGradient(colors: UIData.kitGradients)),
        //     child: new Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         SizedBox(
        //           height: double.infinity,
        //           child: new InkWell(
        //             radius: 10.0,
        //             splashColor: Colors.yellow,
        //             onTap: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (C) => SettingsPage(),
        //                 ),
        //               );
        //             },
        //             child: Center(
        //               child: new Text(
        //                 "ACCOUNTS",
        //                 style: new TextStyle(
        //                     fontSize: 14.0,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.white),
        //               ),
        //             ),
        //           ),
        //         ),
        //         new SizedBox(
        //           width: 20.0,
        //         ),
        //         SizedBox(
        //           height: double.infinity,
        //           child: new InkWell(
        //             onTap: () {},
        //             radius: 10.0,
        //             splashColor: Colors.yellow,
        //             child: Center(
        //               child: new Text(
        //                 "RESTAURANTS",
        //                 style: new TextStyle(
        //                     fontSize: 14.0,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.white),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          //backgroundColor: Colors.orange,
          onPressed: () {
           
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (C) => ChooseToOrder(data),
                ),
              );
            
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Dashboard'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.list),
          //     onPressed: () {
          //       if (!myUser.admin)
          //         checkAdmin();
          //       else {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (C) => Report(),
          //           ),
          //         );
          //       }
          //     },
          //   ),
            // IconButton(
            //   icon: Icon(Icons.attach_money),
            //   onPressed: () {
            //     if (!myUser.admin)
            //       checkAdmin();
            //     else {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (c) => PayCash(data),
            //         ),
            //       );
            //     }
            //   },
            // ),
            // PopupMenuButton<String>(
            //   onSelected: choiceAction,
            //   itemBuilder: (BuildContext conext) {
            //     return Constants.choices.map((String choice) {
            //       return PopupMenuItem<String>(
            //         value: choice,
            //         child: Text(choice),
            //       );
            //     }).toList();
            //   },
            // )
          // ],
          // bottom: TabBar(
          //   tabs: <Widget>[
          //     Tab(
                // icon: Icon(Icons.account_balance),
                // text: 'Accounts',
          //     ),
          //     Tab(
          //       icon: Icon(Icons.restaurant),
          //       text: 'Restaurants',
          //     ),
          //   ],
          // ),
        ),
        bottomNavigationBar: Material(
          color: Colors.black,
          child: TabBar(tabs: <Widget>[
            Tab(text: ('Accounts'),),
            Tab(text: ('Restaurants'),)
          ],),
          
        ),
        body: TabBarView(
          children: <Widget>[
            AccountsPages(),
            ResturantsPages(),
          ],
        ),
      ),
    );
  }

  // FOR THE POPUP MENU
  // void choiceAction(String choice) {
  //   if (choice == Constants.Settings) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (C) => SettingsAdminPage(),
  //       ),
  //     );
  //   } else if (choice == Constants.SignOut) {
  //     Local().deleteUser(myUser.id).then((onValue) {
  //       if (onValue == 1) {
  //         myUser = null;
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (C) => MyApp(false)));
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text("Information"),
  //               content: new Text('You are still login'),
  //             );
  //           },
  //         );
  //       }
  //     });
  //   }
  // }

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
}
