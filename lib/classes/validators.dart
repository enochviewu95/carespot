import 'dart:async';

import 'package:flutter/material.dart';

/*Validator class to validate email and password*/
class Validators {
  //Email validators using stream transformers.
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') && email.contains('.')) {
      sink.add(email);
    } else if (email.isEmpty) {
      sink.addError('Enter a valid email');
    }
  });

  //Password validator using stream transformers.
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else if (password.isEmpty) {
      sink.addError('Password needs to be at least 6 characters');
    }
  });
  
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name,sink){
      if(name.isNotEmpty && name.contains(RegExp('[a-zA-Z]'))){
        sink.add(name);
      }else if(name.isEmpty){
        sink.addError('Field cannot be empty');
      }
    }
  );

  final validateDateOfBirth = StreamTransformer<TextEditingController,TextEditingController>.fromHandlers(
    handleData: (dateOfBirth,sink){
      if(dateOfBirth.text.isNotEmpty){
        sink.add(dateOfBirth);
      }else if(dateOfBirth.text.isEmpty){
        sink.addError('Please specify your date of birth');
      }
    }
  );

  final validateGender = StreamTransformer<TextEditingController,TextEditingController>.fromHandlers(
    handleData: (gender,sink){
      if(gender.text.isNotEmpty){
        sink.add(gender);
      }else if(gender.text.isEmpty){
        sink.addError('Please specify your gender');
      }
    }
  );
}
