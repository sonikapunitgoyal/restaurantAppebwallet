import 'package:app1/model/UserOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';
class UserOrderDAO {
  Future<QuerySnapshot> getAllUserOrders() {
    return Support.tabelUserOrder.getDocuments();
  }

  DocumentReference getUserOrder({String id}) {
    return Support.tabelUserOrder.document(id);
  }

  Future<QuerySnapshot> getUserOrderBy({String field, String value}) {
    return Support.tabelUserOrder.where(field, isEqualTo: value).getDocuments();
  }

  void saveOrderToUser({UserOrder order}) {
    Support.tabelUserOrder.document().setData(order.toJson());
  }
}
