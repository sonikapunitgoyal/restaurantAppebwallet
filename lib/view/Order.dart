import 'package:app1/controller/dao/OrderDAO.dart';
import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/controller/dao/UserOrderDAO.dart';
import 'package:app1/model/Order.dart';
import 'package:app1/model/Resturant.dart';
import 'package:app1/model/User.dart';
import 'package:app1/model/UserOrder.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app1/utils/uidata.dart';

class OrderPage extends StatefulWidget {
  final List<User> data;
  final int length;

  const OrderPage(this.data, this.length, {Key key}) : super(key: key);
  _OrderPageState createState() => _OrderPageState(data, length);
}

class _OrderPageState extends State<OrderPage> {
  final List<User> data;
  final int length;
  TextEditingController _orderAmountController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();

  num orderAmount = 0;
  num deliveryCharge = 0;
  num total = 0;
  List<Resturant> resturants = List();
  List<String> resturantnames = List<String>();

  List<TextEditingController> _orderCostController = List();
  List<TextEditingController> _userpaiedController = List();

  String selectedRest = "None";

  _OrderPageState(this.data, this.length) {
    print(data);
    resturantnames.add("None");
    resturants.add(Resturant(name: resturantnames[0]));
    _orderAmountController.text = "";
    _deliveryController.text = "";
    data.forEach((user) {
      _orderCostController.add(TextEditingController());
      _userpaiedController.add(TextEditingController());
      // print(user);
    });
  }
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEW ORDER PAGE"),
        elevation: 0,
      ),
      body: Card(
        child: ListView(
          padding: EdgeInsets.only(bottom: 40),
          children: <Widget>[
            // THE CARD THAT HOLD BOTH ORDER AMOUNT AND DELIVERY CARDS //
            Card(
              //elevation: 3,
              child: Column(
                children: <Widget>[
                  // THE RESTURANT CARD //
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("RESTURANT"),
                        Card(
                          child: Container(
                            width: 200,
                            child: DropdownButton<String>(
                              items: resturantnames.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (mounted)
                                  setState(() {
                                    selectedRest = val;
                                  });
                              },
                              value: selectedRest,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //THE ORDER AMOUNT CARD //
                  TextField(
                    controller: _orderAmountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    //maxLength: 19,
                    style: TextStyle(
                        fontFamily: UIData.ralewayFont, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Order Amount",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder()),
                    onChanged: (s) {
                      setState(() {
                        orderAmount = Support.round(
                            num.tryParse(_orderAmountController.text));
                        orderAmount = total = deliveryCharge + (orderAmount);
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _deliveryController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    //maxLength: 19,
                    style: TextStyle(
                        fontFamily: UIData.ralewayFont, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Delivery Charge",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (s) {
                      setState(
                        () {
                          deliveryCharge = Support.round(
                            num.tryParse(_deliveryController.text),
                          );
                          total = (deliveryCharge) + orderAmount;
                        },
                      );
                    },
                  ),

                  // THE CARD HOLDING THE TOTAL AMOUNT //
                  Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(80.0),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF015FFF),
                            Color(0xFF015FFF),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Total Order : BD ${Support.formatNum(total)}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ),
                          ),
                          //SizedBox(height: 35.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 20,
                  child: Text("USER"),
                ),
                Container(
                  height: 20,
                  child: Text("ORDER COST"),
                ),
                Container(
                  height: 20,
                  child: Text("DELIVERY"),
                ),
                Container(
                  height: 20,
                  child: Text("PAIED"),
                )
              ],
            ),
            Container(
              height: 220,
              child: Card(
                child: ListView.builder(
                  itemBuilder: (C, i) => itamBuilder(i),
                  itemCount: length,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "CANCEL",
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (C) => DashboardMainPage()));
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "OK",
                    ),
                    onPressed: () {
                      checkOK();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  _verticalDivider() => BoxDecoration(
//        border: Border(
//          left: BorderSide(
//              color: Colors.blue, width: 1.5, style: BorderStyle.solid),
//        ),
//      );

  Widget itamBuilder(int i) {
    //String _username = Support.prepareString(data[i].username, 4);
    //print(_username.length);
    return Card(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 70,
            child: Text(data[i].firstName),
          ),
          Card(
            color: Colors.blueGrey[100],
            child: Container(
              width: 70,
              child: TextField(
                controller: _orderCostController[i],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ),
          Text((Support.formatNum(deliveryCharge / length))),
          Card(
            color: Colors.blueGrey[100],
            child: Container(
              width: 70,
              child: TextField(
                controller: _userpaiedController[i],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkOK() {
    List<num> orderCost = List(length);
    num orderCostSum = 0;

    List<num> paied = List(length);
    num paiedSum = 0;
    for (var i = 0; i < length; i++) {
      orderCost[i] = Support.getNum(_orderCostController[i].text);
      print("order per user $i  ${orderCost[i]}");
      orderCostSum += orderCost[i];

      //---
      paied[i] = Support.getNum(_userpaiedController[i].text);
      print("paied $i  ${paied[i]}");
      paiedSum += paied[i];
    }
    if (orderCostSum != orderAmount) {
      print(paiedSum);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('The order cost is $orderAmount'),
          );
        },
      );
    } else if (paiedSum != total) {
      print(paiedSum);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Worning"),
            content: new Text('The total paied amount is not equal $total'),
          );
        },
      );
    } else {
      OrderDAO _orderDao = OrderDAO();
      List<String> users = List();
      data.forEach((f) {
        users.add(f.id);
      });
      DocumentReference orderPath = _orderDao.saveOrder(
          order: Order(
              date: DateTime.now(),
              amount: orderAmount,
              deliveryCharge: deliveryCharge,
              totalOrderCost: total,
              usersOrders: users,
              restaurant: resturants[resturantnames.indexOf(selectedRest)].id));
      UserDAO userDAO = UserDAO();
      UserOrderDAO userOrderDao = UserOrderDAO();
      for (var i = 0; i < length; i++) {
        num totalUser = orderCost[i] + deliveryCharge / length;
        num diffPlus = paied[i] - totalUser;
        userOrderDao.saveOrderToUser(
            order: UserOrder(
                orderId: orderPath.path,
                userId: data[i].id,
                paied: paied[i],
                deliveryCostPerUser: deliveryCharge / length,
                orderCost: orderCost[i]));
        if (diffPlus != 0) userDAO.addAmount(data[i], diffPlus);
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
    }
  }

  void init() {
    ResturantDAO().getAllResturants().then((onValue) {
      if (mounted)
        setState(() {
          onValue.documents.forEach((doc) {
            Resturant res = Resturant.fromDocument(doc);
            print(res);
            resturants.add(Resturant.fromDocument(doc));
            resturantnames.add(res.name);
          });
        });
    });
  }
}
