import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  final String uid;
  CustomUser({this.uid});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userEmail;

  String getEmail() {
    String userEmail = _auth.currentUser.email;
    return userEmail;
  }

  // CREATE USER
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // USER STREAM
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //SIGN IN WITH EMAIL AND PASS
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print("error: " + e.toString());
      return null;
    }
  }

  //SIGN OUT
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
