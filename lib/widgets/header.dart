import 'package:carespot/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Bruce Leslie',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ComponentColors.primaryColor),
        ),
        IconButton(
            iconSize: MediaQuery.of(context).size.width / 12,
            onPressed: null,
            icon: const Icon(
              Icons.notifications_outlined,
              color: ComponentColors.primaryColor,
            ))
      ],
    );
  }
}
