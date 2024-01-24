import 'package:firebase_sample_app/models/brew.dart';
import 'package:firebase_sample_app/screens/home/brew_list.dart';
import 'package:firebase_sample_app/screens/home/settings_form.dart';
import 'package:firebase_sample_app/services/auth.dart';
import 'package:firebase_sample_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          backgroundColor: Colors.brown.shade400,
          title: Text(
            'Brew Crew',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {
                  _showSettingsPanel();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                )),
            IconButton(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.logout, color: Colors.white)),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
