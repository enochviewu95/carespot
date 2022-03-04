import 'package:carespot/widgets/stack_component.dart';
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
            ],
          ),
        )),
        bottomNavigationBar: const BottomNavigation());
  }
}


