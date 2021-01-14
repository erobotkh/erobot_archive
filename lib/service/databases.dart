import 'package:cloud_firestore/cloud_firestore.dart';

class ErobotMember {
  final String uid;
  final String name;
  final String email;
  final int phone;

  ErobotMember({this.uid, this.name, this.email, this.phone});
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(String name, String email, int phone) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'email': email, 'phone': phone});
  }

  ErobotMember _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return ErobotMember(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phone: snapshot.data()['phone'],
    );
  }

  Stream<ErobotMember> get userData {
    return userCollection.doc(uid).snapshots().map((_userDataFromSnapshot));
  }
}
