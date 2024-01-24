import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/screens/authenticate/authenticate.dart';
import 'package:firebase_sample_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // return either Authenticate or Home
    return (user == null) ? Authenticate() : Home();
  }
}
