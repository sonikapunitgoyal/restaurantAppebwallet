import 'package:app1/model/User.dart';
import '../support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDAO {
  Future<QuerySnapshot> getAllUsers() {
    return Support.tabelUser.getDocuments();
  }

  Future<DocumentSnapshot> getUser({String id}) {
    return Support.tabelUser.document(id).get();
  }

  Future<QuerySnapshot> getUserBy({String field, dynamic value}) {
    return Support.tabelUser.where(field, isEqualTo: value).getDocuments();
  }

  Future<void> saveUser({User user}) {
    return Support.tabelUser.document().setData(user.toJson());
  }

  void remove(String docID) {
    Support.tabelUser.document(docID).delete();
  }

  void update({User user}) {
    Support.tabelUser.document(user.id).updateData(user.toJson());
  }

  void addAmount(User user, num plus) {
    print(user);
    Support.tabelUser.document(user.id)
        .updateData({"amount": user.amount + plus});
  }
// void a(User user,) {
//      final DocumentReference postRef =  support.TabelUser.document(user.id);
//     Firestore.instance.runTransaction((Transaction tx) async {
//       DocumentSnapshot postSnapshot = await tx.get(postRef);
//       if (postSnapshot.exists) {
//         await tx.update(postRef, <String, dynamic>{
//           'likesCount': postSnapshot.data['likesCount'] + 1
//         });
//       }
//     });
//   }
  Future<void> updateAllAmount({int amount}) {
   return getAllUsers().then((onValue) {
      onValue.documents.forEach((doc) {
        User user = User.fromDocument(doc);
        user.amount = 0;
        update(user: user);
      });
    });
  }

  void setAdmin(User user) {
    Support.tabelUser.document(user.id).updateData({"admin": true});
  }

  Query getUserByUsernameAndPass({String username }) {
    return Support.tabelUser.where("username",isEqualTo: username) ;
  }
}
