import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});  

  //collection reference 
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }

  //brew list form snapshot 
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name')?? '', //if empty return ''
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? ''
        );
    }).toList();
  }

  //userData from snapshot
 UserData _userDataFromSnapshot (DocumentSnapshot snapshot){
  return UserData(
    uid: uid, 
    name: snapshot['name'], 
    sugars: snapshot['sugars'], 
    strength: snapshot['strength']);
 }

  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapShot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}