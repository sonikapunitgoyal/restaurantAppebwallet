import 'package:app1/model/Resturant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';

class ResturantDAO {
  Future<QuerySnapshot> getAllResturants() {
    return Support.tabelResturant.limit(100).orderBy("name"). getDocuments();
  }

  DocumentReference getResturant({String id}) {
    return Support.tabelResturant.document(id);
  }

  Future<QuerySnapshot> getResturantBy({String field, String value}) {
    return Support.tabelResturant.where(field, isEqualTo: value).getDocuments();
  }

  DocumentReference saveResturant({Resturant resturant}) {
    DocumentReference path = Support.tabelResturant.document();
    path.setData(resturant.toJson());
    return path;
  }
}
