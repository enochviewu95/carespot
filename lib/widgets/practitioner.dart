import 'package:carespot/utils/colors.dart';
import 'package:carespot/widgets/practitioner_card.dart';
import 'package:flutter/material.dart';

class PractitionersComponent extends StatelessWidget {
  const PractitionersComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'assets/images/nurse.png',
      'assets/images/doctor.png'
    ];
    final List<String> names = <String>['Nurse Azia', 'Dr. Daemon'];
    final List<String> distance = <String>['3', '4'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Practitioners',
          style: TextStyle(
              color: ComponentColors.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return PractitionerCardComponent(
                  entries: entries[index],
                  names: names[index],
                  distance: distance[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                    width: MediaQuery.of(context).size.width / 35,
                  ),
              itemCount: entries.length),
        ),
      ],
    );
  }
}
