import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn ({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService.initializeApp();

  //text field state
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: (){widget.toggleView();}, 
            icon: const Icon(Icons.person,color: Colors.black,), 
            label: const Text("Register",style: TextStyle(color: Colors.black),))
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
                  child: const Text('Sign in',
                      style: TextStyle(color: Colors.white)))
            ],
          )

          //TextButton(
          //   child: const Text('SIGN IN ANONYMOSLY'),
          //   onPressed: () async {
          //     dynamic result = await _auth.signInAnon();
          //     if (result == null) {
          //       print('error user not signed in');
          //     } else {
          //       print('signed in');
          //       print(result.uid);
          //     }
          //   },
          // ),
          ),
    );
  }
}
