import 'package:firebase_sample_app/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});
  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('lib/assets/coffee_icon.png'),
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
