import 'package:attendance_check/view/entrance/model/entrance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldAddInfo extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const TextFieldAddInfo({super.key,
    required this.hint,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        enabled: enabled,
      ),
    );
  }
}