import 'package:carespot/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchFieldComponent extends StatelessWidget {
  const SearchFieldComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: const TextStyle(fontSize: 25.0, color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: MediaQuery.of(context).size.width / 10,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
          filled: true,
          fillColor: ComponentColors.primaryColor,
        ),
      );
  }
}
