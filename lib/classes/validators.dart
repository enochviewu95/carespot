import 'dart:async';

/*Validator class to validate email and password*/
class Validators{

  //Email validators using stream transformers.
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(
        handleData: (email,sink){
          if(email.contains('@') && email.contains('.')){
            sink.add(email);
          }else if(email.isEmpty){
            sink.addError('Enter a valid email');
          }
        }
      );

  //Password validator using stream transformers.
  final validatePassword =
      StreamTransformer<String,String>.fromHandlers(
        handleData: (password, sink){
          if(password.length >= 6){
            sink.add(password);
          }else if(password.isEmpty){
            sink.addError('Password needs to be at least 6 characters');
          }
        }
      );
}