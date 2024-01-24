import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/screens/loading.dart';
import 'package:firebase_sample_app/services/auth.dart';
import 'package:firebase_sample_app/shared/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key, required this.toggle});
  final Function toggle;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _signInKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown.shade100,
            appBar: AppBar(
              backgroundColor: Colors.brown.shade400,
              title: Text('Sign In'),
              actions: [
                TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      widget.toggle();
                    },
                    icon: Icon(Icons.app_registration),
                    label: Text('Register'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _signInKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) =>
                              (value ?? '').isEmpty ? 'Enter email' : null,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          validator: (value) => (value ?? '').length < 6
                              ? 'Enter password with 6 or more characters'
                              : null,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.brown.shade400)),
                            onPressed: () async {
                              if (_signInKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                UserCredential? userCredential =
                                    await _authService.signInWithEmailAndPwd(
                                        email, password);
                                if (userCredential == null) {
                                  setState(() {
                                    isLoading = false;
                                    error = 'Not valid credentials';
                                  });
                                } else {
                                  print(userCredential);
                                }
                              }
                            },
                            child: Text('Sign In',
                                style: TextStyle(color: Colors.white))),
                        SizedBox(height: 20),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ))),
          );
  }
}
