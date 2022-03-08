import 'package:carespot/bloc/authentication_bloc.dart';
import 'package:carespot/bloc/authentication_bloc_provider.dart';
import 'package:carespot/pages/home.dart';
import 'package:carespot/pages/login_page.dart';
import 'package:carespot/services/authentication.dart';
import 'package:carespot/services/authentication_api.dart';
import 'package:carespot/services/db_firestore.dart';
import 'package:carespot/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_bloc_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final AuthenticationService _authenticationService =
        AuthenticationService();
    final AuthenticationBloc _authenticationBloc =
        AuthenticationBloc(authenticationApi: _authenticationService);

    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
        initialData: null,
        stream: _authenticationBloc.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('Snapshot $snapshot');
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('printed data: ${snapshot.data}');
            return Container(
                color: ComponentColors.primaryColor,
                child: const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ));
          } else if (snapshot.hasData) {
            print('printed data: ${snapshot.data}');
            return HomeBlocProvider(key,
                homeBloc:
                    HomeBloc(DbFirestoreService(), _authenticationService),
                uid: snapshot.data,
                child: _buildMaterialApp(const Home()));
          } else {
            print('printed data: ${snapshot.data}');
            return _buildMaterialApp(const LoginPage());
          }
        },
      ),
    );
  }


  MaterialApp _buildMaterialApp(Widget homePage) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homePage,
    );
  }
}
