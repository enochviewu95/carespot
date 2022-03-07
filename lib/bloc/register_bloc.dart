import 'dart:async';

class RegisterBloc {
  /*Assign to register_bloc*/
  final StreamController<String> _loginOrCreateButtonController = StreamController<String>();
  Sink<String> get loginOrCreateButtonChanged => _loginOrCreateButtonController.sink;
  Stream<String> get loginOrCreateButton => _loginOrCreateButtonController.stream;
}