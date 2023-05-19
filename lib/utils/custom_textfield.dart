import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.txt,
    required this.ctrl,
  });

  final String txt;
  final TextEditingController ctrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Please enter $txt";
        }
        return null;
      },
      controller: ctrl,
      decoration: InputDecoration(
          hintText: txt,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey))),
    );
  }
}
