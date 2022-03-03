import 'package:carespot/widgets/card.dart';
import 'package:flutter/material.dart';

class StackComponent extends StatelessWidget {
  const StackComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 65, right: 0, bottom: 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: const CardComponent(),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width / 70,
          bottom: MediaQuery.of(context).size.height / 180,
          child: Image.asset(
            'images/nurse.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width / 2,
          ),
        )
      ],
    );
  }
}
