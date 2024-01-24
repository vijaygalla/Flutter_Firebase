import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/screens/loading.dart';
import 'package:firebase_sample_app/services/auth.dart';
import 'package:firebase_sample_app/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _registerKey = GlobalKey<FormState>();
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
              title: Text('Register'),
              actions: [
                TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.login),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                    key: _registerKey,
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
                              if (_registerKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                UserCredential? userCredential =
                                    await _authService.registerWithEmailAndPwd(
                                        email, password);
                                if (userCredential == null) {
                                  setState(() {
                                    error = 'Please enter valid email';
                                    isLoading = false;
                                  });
                                } else {
                                  print(userCredential);
                                }
                              }
                            },
                            child: Text('Register',
                                style: TextStyle(color: Colors.white))),
                        SizedBox(height: 20),
                        Text(error, style: TextStyle(color: Colors.red))
                      ],
                    ))),
          );
  }
}
