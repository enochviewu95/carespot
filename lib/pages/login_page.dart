import 'package:carespot/services/authentication.dart';
import 'package:carespot/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';

  void onGoogleSignClick() {
    final auth = AuthenticationService();
    final credentials = auth.signInWithGoogle();
    setState(() {
      _email = credentials.toString();
    });
    // auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: ComponentColors.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('This is email $_email'),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                elevation: MaterialStateProperty.all(10.0),
              ),
              onPressed: () => onGoogleSignClick(),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Sign In with google',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              icon: Image.asset(
                'assets/images/google.png',
                width: 30.0,
              ),
            )
          ],
        ),
      )),
    );
  }
}
