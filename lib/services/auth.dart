import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
  // Sign in anonymously

  Future signInAnonymously() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      return credential;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign in with Email & Password
  Future signInWithEmailAndPwd(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register with Email & Password
  Future registerWithEmailAndPwd(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create new document for the user with uid
      await DatabaseService(uid: userCredential.user?.uid ?? "")
          .updateUserData('0', 'new crew member', 100);
      return userCredential;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
