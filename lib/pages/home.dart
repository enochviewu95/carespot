import 'package:carespot/bloc/authentication_bloc.dart';
import 'package:carespot/services/authentication.dart';
import 'package:carespot/widgets/stack_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';
import '../widgets/practitioner.dart';
import '../widgets/search_field.dart';
import '../widgets/specialists.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationBloc? _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const HeaderComponent(),
              const StackComponent(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30),
              const SearchFieldComponent(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30),
              const SpecialistComponent(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30),
              const PractitionersComponent(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    shadowColor: Colors.grey,
                    onSurface: Colors.lightGreen.shade400,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              )
            ],
          ),
        )),
        bottomNavigationBar: const BottomNavigation());
  }

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(authenticationApi: AuthenticationService());
  }
}
