import 'package:flutter/material.dart';
import 'package:carespot/bloc/authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  //Declaration of authentication bloc
  final AuthenticationBloc authenticationBloc;

  const AuthenticationBlocProvider(
      {Key? key,required Widget child, required this.authenticationBloc})
      : super(key: key, child: child);

  static AuthenticationBlocProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthenticationBlocProvider>();
  }

  @override
  bool updateShouldNotify(AuthenticationBlocProvider oldWidget) =>
      authenticationBloc != oldWidget.authenticationBloc;
}
