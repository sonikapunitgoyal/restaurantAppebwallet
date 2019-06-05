import 'package:cloud_firestore/cloud_firestore.dart';

class Support {
  static Firestore firebase = Firestore.instance;
  static CollectionReference tabelUser = firebase.collection("users");
  static CollectionReference tabelOrder = firebase.collection("order");
  static CollectionReference tabelUserOrder = firebase.collection("userOrder");
  static CollectionReference tabelResturant = firebase.collection("resturant");
}
