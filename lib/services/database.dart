import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample_app/models/brew.dart';
import 'package:firebase_sample_app/models/user_data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  // brews from snapshot
  List<Brew> _brewsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var object = doc.data() as Map;
      return Brew(
          name: object['name'] ?? '',
          sugars: object['sugar'] ?? '',
          strength: object['strength'] ?? 0);
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var object = snapshot.data() as Map;
    return UserData(
        uid: uid,
        name: object['name'],
        sugars: object['sugar'],
        strength: object['strength']);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewsListFromSnapshot);
  }

  // get user data stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
