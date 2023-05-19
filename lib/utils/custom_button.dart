import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.txt, required this.onTap});

  final String txt;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
      ),
      child: Text(txt),
    );
  }
}
