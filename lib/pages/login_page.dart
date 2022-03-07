import 'package:carespot/bloc/login_bloc.dart';
import 'package:carespot/services/authentication.dart';
import 'package:carespot/utils/colors.dart';
import 'package:flutter/material.dart';

import '../classes/authentication_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String _email = '';
  LoginBloc? _loginBloc;

  //
  // void onGoogleSignClick() {
  //   final auth = AuthenticationService();
  //   final credentials = auth.signInWithGoogle();
  //   setState(() {
  //     _email = credentials.toString();
  //   });
  //   // auth.signOut();
  // }

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  @override
  void dispose() {
    _loginBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ComponentColors.primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      StreamBuilder(
                        stream: _loginBloc?.email,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) =>
                                TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            labelText: 'Email Address',
                            errorText: snapshot.error != null
                                ? snapshot.error.toString()
                                : '',
                          ),
                          onChanged: _loginBloc?.emailChanged.add,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      StreamBuilder(
                        stream: _loginBloc?.password,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) =>
                                TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Password',
                            errorText: snapshot.error != null
                                ? snapshot.error.toString()
                                : '',
                          ),
                          onChanged: _loginBloc?.passwordChanged.add,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      _buildLoginAndCreateButtons(),
                    ],
                  ),
                ))),
        bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                      color: ComponentColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            )));
  }

  Widget _buildLoginAndCreateButtons() {
    return _buttonsLogin();
  }

  Column _buttonsLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
            initialData: false,
            stream: _loginBloc?.enableLoginButton,
            builder: (BuildContext context, AsyncSnapshot snapshot) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: snapshot.data
                        ? () => _loginBloc?.loginClicked.add('Login')
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: ComponentColors.primaryColor,
                      elevation: 16.0,
                      onSurface: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                  ),
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        StreamBuilder(
            initialData: '',
            stream: _loginBloc?.client,
            builder: (BuildContext context, AsyncSnapshot snapshot) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        elevation: MaterialStateProperty.all(10.0),
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    onPressed: () => _loginBloc?.googleSignInClicked.add(GoogleSignInEvent()),
                    label:  Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'Sign In with google ${snapshot.data}',
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/google.png',
                      width: 30.0,
                    ),
                  ),
                )),
      ],
    );
  }
}
