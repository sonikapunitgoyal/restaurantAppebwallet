import 'package:flutter/material.dart';
import 'package:app1/controller/dao/OrderDAO.dart';
import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/model/Order.dart';
import 'package:app1/model/Resturant.dart';

class HistoryReport extends StatefulWidget {
  @override
  _HistoryReportState createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  List<View> data = List();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (c, i) => item(i),
            itemCount: data.length,
          ),
        ),
      ],
    );
  }

  Widget item(int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(data[index].resturant.name ?? "resturant"),
        leading: CircleAvatar(child: Text("${data[index].order.amount ?? ""}")),
        trailing: Text(formatDate(data[index].order.date)),
      ),
    );
  }

  String formatDate(DateTime dat) {
    return "${dat.day}/${dat.month}";
  }

  void init() {
    var dao = ResturantDAO();
    OrderDAO().getAllOrders().then((onValue) {
      onValue.documents.forEach((doc) {
        Order order = Order.fromDocument(doc);
        print(order);
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
