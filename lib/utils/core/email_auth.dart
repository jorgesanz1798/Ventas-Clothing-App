import 'package:firebase_auth/firebase_auth.dart';
import 'package:ventasclothing/core/providers/auth_service.dart';

class EmailAuthService {
  static Future<void> registerWithEmailAndPassword(
      emailUser, passwordUser) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailUser, password: passwordUser);
      User? _user = FirebaseAuth.instance.currentUser;
      AuthService _authentication = AuthService();
      _authentication.addUser(_user!.uid);
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
