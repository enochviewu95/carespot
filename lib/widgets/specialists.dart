import 'package:carespot/utils/colors.dart';
import 'package:carespot/widgets/specialist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialistComponent extends StatelessWidget {
  const SpecialistComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Specialist',
          style: TextStyle(
            color: ComponentColors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                scrollDirection: Axis.horizontal,
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return const SpecialistCardComponent();
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: MediaQuery.of(context).size.width / 25,
                    )))
      ],
    );
  }
}
