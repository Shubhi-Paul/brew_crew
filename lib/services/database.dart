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
  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapShot);
  }

}