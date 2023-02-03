import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constansts.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0' , '1', '2', '3' , '4'];

  String? _currentName;
  String? _currentSugar; 
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<OurUser>(context);
    print("user = $user");

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
        UserData? userData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(children: [
            const Text(
              "Update your brew settings.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: userData?.name,
              decoration: textInputDecoration,
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              onChanged :(name) => setState(() {
                _currentName = name;
              }),),
              const SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                decoration: textInputDecoration,
                value: _currentSugar ?? userData?.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text("$sugar sugars"),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugar = val!),
              ),
              Slider(
                value: (_currentStrength?? userData!.strength).toDouble(), 
                min: 100.0,
                max: 900.0,
                divisions: 8,
                activeColor: Colors.brown[_currentStrength ?? userData!.strength]!,
                inactiveColor: Colors.brown[_currentStrength ?? userData!.strength]!,
                onChanged: (val) {
                  setState(() {
                  _currentStrength = val.round();
                });
                }  
              ),
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.pink),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()){
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugar);

                      await DatabaseService(uid: user.uid)
                        .updateUserData(
                          _currentSugar ?? userData!.sugars,
                          _currentName ?? userData!.name,
                          _currentStrength ?? userData!.strength);
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text(
                    'Update',
                  style: TextStyle(color: Colors.white),)),
              ),
          ]),
        );}
        else{
          return const Loading();
        }
      }
    );
  }
}