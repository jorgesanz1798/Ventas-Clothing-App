import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(emailUser, passwordUser) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailUser, password: passwordUser);
      print(emailUser);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
