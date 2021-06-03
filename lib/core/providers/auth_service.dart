import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static bool existUser = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(uid) async {
    await users.get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach(
            (doc) {
              if (user!.uid == doc["id"]) {
                existUser = true;
              }
            },
          ),
        );
    if (existUser == false) {
      return users
          .add({
            "id": user!.uid,
            "email": user!.email,
          })
          .then((value) => print('User added'))
          .catchError((error) => print('Failed to add user'));
    }
  }
}
