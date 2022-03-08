import 'dart:async';
import 'package:carespot/services/authentication_api.dart';
import 'package:flutter/foundation.dart';

class AuthenticationBloc {
  //Declare of Authentication Api
  final AuthenticationApi authenticationApi;

  //Stream controller (box) to hold user
  final StreamController<String?> _authenticationController =
      StreamController<String?>();

  Sink<String?> get addUser => _authenticationController
      .sink; //Stream to get data into stream controller
  Stream<String?> get user =>
      _authenticationController.stream; //stream to output data

  //Stream controller (box) to logout user
  final StreamController<bool> _logoutController = StreamController<bool>();

  Sink<bool> get _logoutUser =>
      _logoutController.sink; //stream to get data into stream controller
  Stream<bool> get listLogoutUser =>
      _logoutController.stream; //stream to output data

  AuthenticationBloc({required this.authenticationApi}) {
    //Check for authentication changes
    if (kDebugMode) {
      print('Listen for authentication changes');
    }
    onAuthChanged();
  }

  void onAuthChanged() {
    if (kDebugMode) {
      print('onAuthChanged method called');
    }
    authenticationApi.getFirebaseAuth()?.authStateChanges().listen((user) {
      if (kDebugMode) {
        print('onAuthChanged method $user');
      }
      final String? uid = user?.uid;
      addUser.add(uid);
    }).onError((error) {
      if (kDebugMode) {
        print('onAuthChanged method Error ${error.toString()}');
      }
    });
    _logoutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }

  void _signOut() {
    authenticationApi.signOut();
  }

  void dispose() {
    _authenticationController.close();
    _logoutController.close();
  }
}
