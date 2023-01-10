import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService.initializeApp();
  AuthService();

  //create user obj based on Firebase user

  OurUser? _userFromFirebaseUser(User user){
      return user != null ? OurUser(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<OurUser?> get user {
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!));
  }
  //sign in anonymous
  Future signInAnon() async {
    try {
      final UserCredential authResult = await _auth.signInAnonymously();
      final User ? user = authResult.user; 
      return _userFromFirebaseUser(user!);  
    } 
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
  Future signOut() async {
    try { return await _auth.signOut();}
    catch(e) {
      print(e.toString());
      return null;
    }
  }

}