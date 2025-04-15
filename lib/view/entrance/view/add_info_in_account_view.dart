import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/view/entrance/model/add_info_in_account_model.dart';
import 'package:attendance_check/view/entrance/widgets/widget_button_app.dart';
import 'package:attendance_check/view/entrance/widgets/widget_text_field_add_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_check/services/firebase_service.dart';

class AddInfoInAccountView extends StatelessWidget {
  const AddInfoInAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddInfoInAccountModel>(
      create: (context) => AddInfoInAccountModel(UserApp(), FirebaseService()),
      child: const _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddInfoInAccountModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавьте информацию'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFieldAddInfo(
                  hint: model.email, enabled: false, onChanged: null),
              const SizedBox(height: 16),
              TextFieldAddInfo(
                  hint: 'Имя',
                  enabled: true,
                  onChanged: (String value) {
                    model.setName(value);
                  }),
              const SizedBox(height: 16),
              TextFieldAddInfo(
                  hint: 'Фамилия',
                  enabled: true,
                  onChanged: (String value) {
                    model.setSurname(value);
                  }),
              const SizedBox(height: 16),
              TextFieldAddInfo(
                  hint: 'Номер телефона',
                  enabled: true,
                  onChanged: (String value) {
                    model.setPhoneNumber(value);
                  }),
              const SizedBox(height: 16),
              TextFieldAddInfo(
                  hint: 'Группа',
                  enabled: model.isGroupFieldEnabled,
                  onChanged: (String value) {
                    model.setGroup(value);
                  }),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Тип пользователя',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                value: model.userType,
                onChanged: (value) {
                  model.setUserType(value!);
                },
                items: const [
                  DropdownMenuItem(value: 'Студент', child: Text('Студент')),
                  DropdownMenuItem(value: 'Староста', child: Text('Староста')),
                  DropdownMenuItem(value: 'Преподователь', child: Text('Преподователь')),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ButtonApp(
                  text: "Сохранить",
                  onChanged: () => model.validateAndSave(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}