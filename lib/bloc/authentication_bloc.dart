import 'dart:async';
import 'package:carespot/services/authentication_api.dart';

import '../classes/authentication_event.dart';

class AuthenticationBloc {
  //Declare of Authentication Api
  final AuthenticationApi authenticationApi;

  //Stream controller (box) to hold user
  final StreamController<String> _authenticationController =
      StreamController<String>();

  Sink<String> get _addUser => _authenticationController
      .sink; //Stream to get data into stream controller
  Stream<String> get user =>
      _authenticationController.stream; //stream to output data


  //For events, exposing only to a sink which is an input
  final StreamController<AuthenticationEvent> _authenticationEventController = StreamController<AuthenticationEvent>();
  Sink<AuthenticationEvent> get authenticationEventSink => _authenticationEventController.sink;


  //Stream controller (box) to logout user
  final StreamController<bool> _logoutController = StreamController<bool>();

  Sink<bool> get _logoutUser =>
      _logoutController.sink; //stream to get data into stream controller
  Stream<bool> get listLogoutUser =>
      _logoutController.stream; //stream to output data

  AuthenticationBloc(this.authenticationApi){

    //Check for authentication changes
    onAuthChanged();

    //Whenever there is a new event, we want to map it to a new state
    _authenticationEventController.stream.listen(_mapEventToAuthChangedState);
  }

  //Maps the event from the ui
void _mapEventToAuthChangedState(AuthenticationEvent event){

}

void onAuthChanged(){
    authenticationApi
        .getFirebaseAuth()
        .authStateChanges()
        .listen((user) {
          final String? uid = user?.uid;
          _addUser.add(uid!);
    });
    _logoutController.stream.listen((logout) {
      if(logout == true){
        _signOut();
      }
    });
}

void _signOut(){
    authenticationApi.signOut();
}

void dispose(){
    _authenticationController.close();
    _logoutController.close();
    _authenticationEventController.close();
}

}
