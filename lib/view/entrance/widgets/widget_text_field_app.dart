import 'package:attendance_check/view/entrance/model/entrance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldApp extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool isConfigPassword;
  final ValueChanged<String>? onChanged;

  const TextFieldApp({super.key, required this.hint,
    required this.isPassword,
    required this.isConfigPassword,
    required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EntranceModel>(context);
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword ? isConfigPassword ? model.showConfirmPassword : model.showPassword : false,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: isPassword ?
        isConfigPassword ?
        IconButton(onPressed: model.setShowConfirmPassword,
          icon: Icon(model.showConfirmPassword ? Icons.visibility_off : Icons.visibility,),
        )
            :
        IconButton(onPressed: model.setShowPassword,
          icon: Icon(model.showPassword ? Icons.visibility_off : Icons.visibility,),
        ) : null,
      ),
    );
  }
}