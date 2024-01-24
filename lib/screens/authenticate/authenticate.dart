import 'package:firebase_sample_app/screens/authenticate/register.dart';
import 'package:firebase_sample_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  @override
  Widget build(BuildContext context) {
    void toggleView() {
      setState(() {
        showSignIn = !showSignIn;
      });
    }

    return showSignIn
        ? SignIn(toggle: toggleView)
        : Register(toggleView: toggleView);
  }
}
