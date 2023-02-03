import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';
class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<OurUser?>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Provider.value(
            value: user,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const SettingsForm(),
            ),
          );
        });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
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
            TextButton.icon(
              onPressed: () => _showSettingsPanel(), 
              icon: const Icon(Icons.settings, color : Colors.black), 
              label: const Text("settings",
              style: TextStyle(
                color : Colors.black
              ),))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              ),
            ),
          child: const BrewList(),
          ),
      ),
    );
  }
}