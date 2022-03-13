import 'dart:async';

import 'package:carespot/classes/validators.dart';
import 'package:flutter/material.dart';

import '../services/authentication_api.dart';
import '../modals/client.dart';

class RegisterBloc with Validators {
  final AuthenticationApi
      _authenticationApi; //Declaration of authentication api

  /*Declaration of variable to hold values from text fields*/
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _dateOfBirth;
  String? _gender;
  String? _password;

  /*Variables to check the validity of values*/
  bool? _firstNameValid;
  bool? _lastNameValid;
  bool? _dateOfBirthValid;
  bool? _genderValid;
  bool? _emailValid;
  bool? _passwordValid;

  Client? _client; //To hold the details of the user

  /*Stream controllers to detect changes in text fields*/
  final StreamController<String> _firstNameController =
      StreamController<String>.broadcast();
  Sink<String> get firstNameChanged => _firstNameController.sink;
  Stream<String> get firstName =>
      _firstNameController.stream.transform(validateName);

  final StreamController<String> _lastNameController =
      StreamController<String>.broadcast();
  Sink<String> get lastNameChanged => _lastNameController.sink;
  Stream<String> get lastName =>
      _lastNameController.stream.transform(validateName);

  final StreamController<String> _emailController =
      StreamController<String>.broadcast();
  Sink<String> get emailChanged => _emailController.sink;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();
  Sink<String> get passwordChanged => _passwordController.sink;
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  final StreamController<TextEditingController> _dateOfBirtController =
      StreamController<TextEditingController>.broadcast();
  Sink<TextEditingController> get dateOfBirthChanged =>
      _dateOfBirtController.sink;
  Stream<TextEditingController> get dateOfBirth =>
      _dateOfBirtController.stream.transform(validateDateOfBirth);

  final StreamController<TextEditingController> _genderController =
      StreamController<TextEditingController>.broadcast();
  Sink<TextEditingController> get genderChanged => _genderController.sink;
  Stream<TextEditingController> get gender =>
      _genderController.stream.transform(validateGender);

  final StreamController<bool> _enableRegisterController =
      StreamController<bool>.broadcast();
  Sink<bool> get enableRegisterButtonChanged => _enableRegisterController.sink;
  Stream<bool> get enableRegisterButton => _enableRegisterController.stream;

  final StreamController<String> _registrationController =
      StreamController<String>();
  Sink<String> get registrationClicked => _registrationController.sink;
  Stream<String> get registration => _registrationController.stream;

  //Constructor
  RegisterBloc(this._authenticationApi) {
    _startListenersIfTextFieldsAreValid();
  }

  //Listener to check if text fields are valid
  void _startListenersIfTextFieldsAreValid() {
    firstName.listen((event) {
      _firstName = event;
      _firstNameValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _firstName = '';
      _firstNameValid = false;
      _updateRegisterEnableButtonStream();
    });

    lastName.listen((event) {
      _lastName = event;
      _lastNameValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _lastName = '';
      _lastNameValid = false;
      _updateRegisterEnableButtonStream();
    });

    email.listen((email) {
      _email = email;
      _emailValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _email = '';
      _emailValid = false;
      _updateRegisterEnableButtonStream();
    });

    password.listen((password) {
      _password = password;
      _passwordValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _password = '';
      _passwordValid = false;
      _updateRegisterEnableButtonStream();
    });

    dateOfBirth.listen((event) {
      _dateOfBirth = event.text;
      _dateOfBirthValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _dateOfBirth = '';
      _dateOfBirthValid = false;
      _updateRegisterEnableButtonStream();
    });

    gender.listen((event) {
      _gender = event.text;
      _genderValid = true;
      _updateRegisterEnableButtonStream();
    }).onError((error) {
      _gender = '';
      _genderValid = false;
      _updateRegisterEnableButtonStream();
    });

    registration.listen((event) {
      event == 'Register' ? _register() : null;
    });
  }

  Future<String> _register() async {
    String _result = '';
    if (_emailValid! && _passwordValid!) {
      await _authenticationApi
          .registerUser(email: _email!, password: _password!)
          .then((user) {
        print('Created user: $user');
        _result = 'Created user: $user';
        _authenticationApi
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

  void _updateRegisterEnableButtonStream() {
    if (_firstNameValid == true &&
        _lastNameValid == true &&
        _emailValid == true &&
        _dateOfBirthValid == true &&
        _genderValid == true &&
        _passwordValid == true) {
      enableRegisterButtonChanged.add(true);
    } else {
      enableRegisterButtonChanged.add(false);
    }
  }
}
