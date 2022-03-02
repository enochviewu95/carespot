import 'package:carespot/utils/colors.dart';
import 'package:flutter/material.dart';

class SpecialistCardComponent extends StatelessWidget {
  const SpecialistCardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ComponentColors.primaryColor
      ),
    );
  }
}
