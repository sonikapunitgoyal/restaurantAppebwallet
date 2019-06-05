import 'package:flutter/material.dart';
import 'package:app1/pages/history_orders.dart';
import 'package:app1/controller/dao/OrderDAO.dart';
import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/model/Order.dart';
import 'package:app1/model/Resturant.dart';
//import 'package:app1/controller/dao/UserDAO.dart';


class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<View> data = List();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Report Page'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: 'Orders',
              ),
              Tab(
                icon: Icon(Icons.transform),
                text: 'Transaction',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HistoryReport(),
            HistoryReport(),
          ],
        ),
      ),
    );
  }
  void init() {
    var dao = ResturantDAO();
    OrderDAO().getAllOrders().then((onValue) {
      onValue.documents.forEach((doc) {
        Order order = Order.fromDocument(doc);
        if (mounted)
          setState(() {
            data.add(
                View(order, Resturant(id: order.restaurant, name: "Resturant")));
          });
        if (mounted)
          setState(() {
            dao.getResturant(id: order.restaurant).get().then((onValue) {
              Resturant resturant = Resturant.fromDocument(onValue);
              int index = data
                  .indexWhere((view) => view.order.restaurant == resturant.id);
              data[index].resturant = resturant;
            });
          });
      });
    });
  }
}
class View {
  Order order;
  Resturant resturant;
  View(this.order, this.resturant);
}
