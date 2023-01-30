import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
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
  Future signInEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new doc for the user with the uid
      await DatabaseService(uid: user!.uid)
      .updateUserData('0','new crew member',100);      

      return _userFromFirebaseUser(user!);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future regEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try { return await _auth.signOut();}
    catch(e) {
      print(e.toString());
      return null;
    }
  }

}