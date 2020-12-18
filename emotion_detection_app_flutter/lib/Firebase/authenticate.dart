import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.email;
    } catch (e) {
      return null;
    }
  }

  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult loginResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = loginResult.user;
      return user.email;
    } catch (e) {
      return null;
    }
  }

  Future userSignOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  Stream<FirebaseUser> get user {
    return _firebaseAuth.onAuthStateChanged;
  }
}
