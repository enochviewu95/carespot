import 'package:carespot/bloc/register_bloc.dart';
import 'package:carespot/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _passwordVisible = false;

  RegisterBloc? _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(AuthenticationService());
  }

  Future<void> showDatePickerDialog() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      TextEditingController dateInput = TextEditingController();
      dateInput.text = formattedDate;
      _registerBloc?.dateOfBirthChanged.add(dateInput);
    }
  }

  /*Method to show a pop menu for the selection of gender*/
  void showPopupMenu(Offset set) async {
    double left = set.dx;
    double top = set.dy;
    String gender = await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem(child: Text('Male'), value: 'Male'),
        const PopupMenuItem(child: Text('Female'), value: 'Female'),
      ],
      initialValue: '',
      position: RelativeRect.fromLTRB(left, top, 50, 0),
    );

    TextEditingController genderInput = TextEditingController();
    genderInput.text = gender;
    _registerBloc?.genderChanged.add(genderInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: ComponentColors.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.firstName,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'First Name',
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : '',
                    ),
                    onChanged: _registerBloc?.firstNameChanged.add,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.lastName,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Last Name',
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : '',
                    ),
                    onChanged: _registerBloc?.lastNameChanged.add,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.email,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Email',
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : '',
                    ),
                    onChanged: _registerBloc?.emailChanged.add,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.dateOfBirth,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      TextField(
                    controller: snapshot.data,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Date of birth',
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : '',
                    ),
                    readOnly: true,
                    onTap: () => showDatePickerDialog(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.gender,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      showPopupMenu(details.globalPosition);
                    },
                    child: TextField(
                      controller: snapshot.data,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Gender',
                        errorText: snapshot.error != null
                            ? snapshot.error.toString()
                            : '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  stream: _registerBloc?.password,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      TextField(
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Password',
                        errorText: snapshot.error != null
                            ? snapshot.error.toString()
                            : ''),
                    onChanged: _registerBloc?.passwordChanged.add,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                StreamBuilder(
                  initialData: false,
                  stream: _registerBloc?.enableRegisterButton,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: snapshot.data ? () => _registerBloc?.registrationClicked.add('Register'):null,
                      style: ElevatedButton.styleFrom(
                        primary: ComponentColors.primaryColor,
                        elevation: 16.0,
                        onSurface: Colors.green,
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an account?",
                    style: TextStyle(
                        color: ComponentColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
        ));
  }
}
