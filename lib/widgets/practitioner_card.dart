import 'package:carespot/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PractitionerCardComponent extends StatelessWidget {

  final String? entries;
  final String? names;
  final String? distance;

  const PractitionerCardComponent({this.entries,this.names,this.distance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const style = TextStyle(
      fontSize: 15,
      color: ComponentColors.primaryColor,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      letterSpacing: 3.0,
      height: 1.5
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ListTile(
        title: Container(
          height: MediaQuery.of(context).size.height/5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: ComponentColors.primaryColor,
            image: DecorationImage(
              image: ExactAssetImage(entries!),
              fit: BoxFit.fitHeight
            )
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$names',style: style,
              ),
              Text('${distance}km',style: style,)
            ],
          ),
        )
      ),
    );
  }
}
