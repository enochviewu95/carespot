import 'dart:async';
import 'package:carespot/classes/authentication_event.dart';
import 'package:carespot/classes/validators.dart';
import 'package:carespot/services/authentication_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../modals/client.dart';

class LoginBloc with Validators {
  final AuthenticationApi authenticationApi;
  String? _email;
  String? _password;
  bool? _emailValid;
  bool? _passwordValid;

  Client? _client;

  final StreamController<String> _emailController =
      StreamController<String>.broadcast();
  Sink<String> get emailChanged => _emailController.sink;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();
  Sink<String> get passwordChanged => _passwordController.sink;
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  final StreamController<bool> _enableLoginButtonController =
      StreamController<bool>.broadcast();
  Sink<bool> get enableLoginButtonChanged => _enableLoginButtonController.sink;
  Stream<bool> get enableLoginButton => _enableLoginButtonController.stream;

  final StreamController<String> _loginController = StreamController<String>();
  Sink<String> get loginClicked => _loginController.sink;
  Stream<String> get login => _loginController.stream;

  final StreamController<AuthenticationEvent> _googleLoginEvent =
      StreamController<AuthenticationEvent>();
  Sink<AuthenticationEvent> get googleSignInClicked => _googleLoginEvent.sink;
  Stream<AuthenticationEvent> get googleSignIn => _googleLoginEvent.stream;

  final StreamController<String?> _customerStateController =
      StreamController<String?>();
  Sink<String?> get _inClient => _customerStateController.sink;
  Stream<String?> get client => _customerStateController.stream;

  LoginBloc(this.authenticationApi) {
    _startListenersIfEmailPasswordAreValid();
  }

  void _startListenersIfEmailPasswordAreValid() {
    email.listen((email) {
      _email = email;
      _emailValid = true;
      _updateEnableLoginButtonStream();
    }).onError((error) {
      _email = '';
      _emailValid = false;
      _updateEnableLoginButtonStream();
    });
    password.listen((password) {
      _password = password;
      _passwordValid = true;
      _updateEnableLoginButtonStream();
    }).onError((error) {
      _password = '';
      _passwordValid = false;
      _updateEnableLoginButtonStream();
    });
    googleSignIn.listen((event) {
      (event is GoogleSignInEvent) ? _signInWithGoogle() : null;
    });

    login.listen((action) {
      action == 'Login' ? _login() :null;
    });
  }

  void _updateEnableLoginButtonStream() {
    if (_emailValid == true && _passwordValid == true) {
      enableLoginButtonChanged.add(true);
    } else {
      enableLoginButtonChanged.add(false);
    }
  }

  Future<void> _signInWithGoogle() async {
    await authenticationApi.signInWithGoogle().then((userCredential) {
      User? user = userCredential?.user;
      if (user != null) {
        if (kDebugMode) {
          print('_signInWithGoogle method: ${user.email}');
        }
        _client = Client(user.email);
        _inClient.add(_client?.email);
      }
    });
  }

  Future<String> _login() async {
    String _result = '';
    if (_emailValid! && _passwordValid!) {
      await authenticationApi
          .signIn(email: _email!, password: _password!)
          .then((user) {
        _result = 'Success';
      }).catchError((error) {
        print('Login error: $error');
        _result = error;
      });
      return _result;
    } else {
      return 'Email and Password are not valid';
    }
  }

  Future<String> _createAccount() async {
    String _result = '';
    if (_emailValid! && _passwordValid!) {
      await authenticationApi
          .registerUser(email: _email!, password: _password!)
          .then((user) {
        print('Created user: $user');
        _result = 'Created user: $user';
        authenticationApi
            .signIn(email: _email!, password: _password!)
            .then((user) {})
            .catchError((error) async {
          print('Login error: $error');
          _result = error;
        });
      }).catchError((error) async {
        print('Creating user error: $error');
      });
      return _result;
    } else {
      return 'Error creating user';
    }
  }

  void dispose() {
    _passwordController.close();
    _emailController.close();
    _enableLoginButtonController.close();
    _loginController.close();
    _googleLoginEvent.close();
    _customerStateController.close();
  }
}
