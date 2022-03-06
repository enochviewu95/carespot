import 'dart:async';
import 'package:carespot/classes/validators.dart';
import 'package:carespot/services/authentication_api.dart';

class LoginBloc with Validators{
  final AuthenticationApi authenticationApi;
  String? _email;
  String? _password;
  bool? _emailValid;
  bool? _passwordValid;

  final StreamController<String> _emailController = StreamController<String>.broadcast();
  Sink<String> get emailChanged => _emailController.sink;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final StreamController<String> _passwordController = StreamController<String>.broadcast();
  Sink<String> get passwordChanged => _passwordController.sink;
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  final StreamController<bool> _enableLoginCreateButtonController = StreamController<bool>.broadcast();
  Sink<bool> get enableLoginCreateButtonChanged => _enableLoginCreateButtonController.sink;
  Stream<bool> get enableLoginCreateButton => _enableLoginCreateButtonController.stream;

  final StreamController<String> _loginOrCreateButtonController = StreamController<String>();
  Sink<String> get loginOrCreateButtonChanged => _loginOrCreateButtonController.sink;
  Stream<String> get loginOrCreateButton => _loginOrCreateButtonController.stream;

  final StreamController<String> _loginOrCreateController = StreamController<String>();
  Sink<String> get loginOrCreateChanged => _loginOrCreateController.sink;
  Stream<String> get loginOrCreate => _loginOrCreateController.stream;

  LoginBloc(this.authenticationApi){
    _startListenersIfEmailPasswordAreValid();
  }

  void _startListenersIfEmailPasswordAreValid(){
    email.listen((email) {
      _email = email;
      _emailValid = true;
      _updateEnableLoginCreateButtonStream();
    }).onError((error){
      _email = '';
      _emailValid = false;
      _updateEnableLoginCreateButtonStream();
    });
    password.listen((password) {
      _password = password;
      _passwordValid = true;
      _updateEnableLoginCreateButtonStream();
    }).onError((error){
      _password = '';
      _passwordValid = false;
      _updateEnableLoginCreateButtonStream();
    });

    loginOrCreate.listen((action) {
      action == 'Login' ? _login() : _createAccount();
    });
  }

  void _updateEnableLoginCreateButtonStream(){
    if(_emailValid == true && _passwordValid == true){
      enableLoginCreateButtonChanged.add(true);
    }else{
      enableLoginCreateButtonChanged.add(false);
    }
  }

  Future<String> _login() async{
    String _result = '';
    if(_emailValid! && _passwordValid!){
      await authenticationApi.signIn(email: _email!, password: _password!).then((user){
        _result = 'Success';
      }).catchError((error){
        print('Login error: $error');
        _result = error;
      });
      return _result;
    }else{
      return 'Email and Password are not valid';
    }
  }

  Future<String> _createAccount() async {
    String _result = '';
    if(_emailValid! && _passwordValid!){
      await authenticationApi.registerUser(email: _email!, password: _password!).then((user){
        print('Created user: $user');
        _result = 'Created user: $user';
        authenticationApi.signIn(email: _email!, password: _password!).then((user){}).catchError((error) async {
          print('Login error: $error');
          _result = error;
        });
      }).catchError((error) async{
        print('Creating user error: $error');
      });
      return _result;
    }else{
      return 'Error creating user';
    }
  }

  void dispose(){
    _passwordController.close();
    _emailController.close();
    _enableLoginCreateButtonController.close();
    _loginOrCreateButtonController.close();
    _loginOrCreateController.close();
  }

}