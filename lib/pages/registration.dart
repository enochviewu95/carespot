import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController genderInput = TextEditingController();
  bool _passwordVisible = false;
  String dropdownValue = 'Male';
  List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    dateInput.text = '';
    genderInput.text = '';
    super.initState();
  }

  Future<void> showDatePickerDialog() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateInput.text = formattedDate;
      });
    }
  }

  void showPopupMenu(Offset set) async {
    double left = set.dx;
    double top = set.dy;
    await showMenu(
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
    ).then<void>((selectedGender) => {
          setState(() {
            if (selectedGender == null) {
              genderInput.text = 'Male';
            }
            genderInput.text = selectedGender.toString();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  child: Text('Register'),
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: dateInput,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Date of birth',
                  ),
                  readOnly: true,
                  onTap: () => showDatePickerDialog(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    showPopupMenu(details.globalPosition);
                  },
                  child: TextField(
                    controller: genderInput,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Gender',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
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
