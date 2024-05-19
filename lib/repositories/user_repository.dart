import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/utils/firebase_collection.dart';
import 'package:todo/models/user_data.dart';
import 'package:todo/repositories/authentication_repository.dart';

class UserRepository {
  final CollectionReference _firestore = FirebaseFirestore.instance.collection(FirebaseCollection.user);

  final AuthenticationRepository authentication = AuthenticationRepository();

  Future<void> createUser(UserData user) {
    return _firestore.doc(user.uid ?? '').set(user.toMap());
  }

  Future<void> updateUser(UserData user) {
    return _firestore.doc(user.uid ?? '').update(user.toMap());
  }

  Future<DocumentSnapshot<UserData>> getUser() async {
    return _firestore
        .doc(authentication.user?.uid ?? '')
        .withConverter(
          fromFirestore: (snapshot, options) => UserData.fromMap(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        )
        .get();
  }

  Future<UserData?> getUserByEmail(String? email) async {
    return _firestore.where('email', isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserData.fromMap(value.docs.first.data());
      } else {
        return null;
      }
    });
  }

  Future<bool> userExits(String email) async {
    return _firestore.where('email', isEqualTo: email).limit(1).get().then((value) => value.docs.isNotEmpty);
  }
}
