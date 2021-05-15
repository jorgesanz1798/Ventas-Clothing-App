import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(uid) {
    return users
        .add({
          "id": user!.uid,
          "email": user!.email,
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user'));
  }
}
