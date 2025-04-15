import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final  VoidCallback? onChanged;

  const ButtonApp({super.key,
    required this.text,
    required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onChanged,
      style: ElevatedButton.styleFrom(
        padding:
        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
