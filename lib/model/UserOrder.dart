// import 'package:app1/model/Support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  String id;
  String userId;
  String orderId;
  num orderCost; //order cost to specific user
  num deliveryCostPerUser;
  num paied; //

  UserOrder(
      {this.userId,
      this.orderId,
      this.orderCost,
      this.deliveryCostPerUser,
      this.paied});
  UserOrder.fromDocument(DocumentSnapshot doc) {
    if (doc.exists) {
      this.id = doc.documentID;
      this.userId = doc.data["User_id"];
      this.orderId = doc.data["Order_id"];
      this.orderCost = doc.data["orderCost"];
      this.deliveryCostPerUser = doc.data["deliveryCostPerUser"];
      this.paied = doc.data["paied"];
    }
  }
  toJson() {
    return {
      "User_id": userId,
      "Order_id": orderId,
      "orderCost": orderCost,
      "deliveryCostPerUser": deliveryCostPerUser,
      " paied": paied,
    };
  }
}
