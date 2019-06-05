import 'package:app1/model/Order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';

class OrderDAO {
  Future<QuerySnapshot> getAllOrders() {
    return Support.tabelOrder.limit(250).orderBy("date", descending: true).getDocuments();
  }

  DocumentReference getOrder({String id}) {
    return Support.tabelOrder.document(id);
  }

  Future<QuerySnapshot> getOrderBy({String field, String value}) {
    return Support.tabelOrder.where(field, isEqualTo: value).getDocuments();
  }

  DocumentReference saveOrder({Order order}) {
    DocumentReference path = Support.tabelOrder.document();
    path.setData(order.toJson());
    return path;
  }
}
