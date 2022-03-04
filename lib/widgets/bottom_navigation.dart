import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Image.asset('assets/images/filepad.png'),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/ambulance.png'),
          ),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/home.png')),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/chat.png')),
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/images/avatar.png')),
        ],
      ),
    ));
  }
}
