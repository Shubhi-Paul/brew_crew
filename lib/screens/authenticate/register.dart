import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   
   final AuthService _auth = AuthService.initializeApp();
   
   //text field state
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: (){widget.toggleView();}, 
            icon: const Icon(Icons.person,color: Colors.black,), 
            label: const Text("Sign in",style: TextStyle(color: Colors.black),))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (val) {setState(() {
                  email = val;
                });},
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (val) {setState(() {
                  password = val;
                });},
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    print("email : $email");
                    print("password : $password");
                  },
                  child: const Text('Register',
                      style: TextStyle(color: Colors.white)))
            ],
          )
          ),
    );
  }
}