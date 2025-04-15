import 'package:attendance_check/view/entrance/model/entrance_model.dart';
import 'package:attendance_check/view/entrance/widgets/widget_button_app.dart';
import 'package:attendance_check/view/entrance/widgets/widget_text_field_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EntranceModel>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Авторизация",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFieldApp(hint: 'Email', onChanged: model.setEmail , isPassword: false, isConfigPassword: false,),
              SizedBox(height: 20),
              TextFieldApp(hint: 'Пароль', onChanged: model.setPassword , isPassword: true, isConfigPassword: false,),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonApp(text: "Войти", onChanged:() => model.authUser(context),),
                  ButtonApp(text: "Зарегистрироваться", onChanged: () => model.goRegistr(context),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
