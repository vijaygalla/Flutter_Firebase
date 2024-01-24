import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/models/user_data.dart';
import 'package:firebase_sample_app/screens/loading.dart';
import 'package:firebase_sample_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_sample_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid ?? '').userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data ??
                UserData(
                    uid: user?.uid ?? '', name: '', sugars: '', strength: 0);
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Please enter a name' : null,
                    onChanged: (value) => setState(() {
                      _currentName = value;
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // drop down
                  DropdownButtonFormField(
                      value: _currentSugar ?? userData.sugars,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text('$sugar sugars'));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugar = val ?? '';
                        });
                      }),
                  Slider(
                      min: 100,
                      max: 900,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.brown,
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.round();
                        });
                      }),
                  // slider
                  SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown.shade400)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user?.uid ?? '')
                              .updateUserData(
                                  _currentSugar ?? userData.sugars,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
