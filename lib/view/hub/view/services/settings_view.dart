import 'package:attendance_check/view/hub/model/services/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ThemeWidget(),
          ],
        ),
      ),
    );
  }
}

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Ночная тема",
          style: TextStyle(fontSize: 24),
        ),
        Switch(
          value: model.isDarkMode,
          onChanged: (value) => model.updateTheme(),
        ),
      ],
    );
  }
}