import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        title: const Text("Brew Crew"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut(); 
            },
             icon: const Icon(Icons.person,color: Colors.black,), 
             label: const Text("logout",style: TextStyle(color: Colors.black,))),
        ],
      ),
    );
  }
}