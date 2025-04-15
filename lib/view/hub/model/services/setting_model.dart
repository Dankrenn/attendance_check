import 'package:attendance_check/services/hive_service.dart';
import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier{
  HiveService hiveService = HiveService();
  late bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  SettingModel() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isDarkMode = await hiveService.getIsDaskMode();
    notifyListeners();
  }

  Future<void> updateTheme() async {
    _isDarkMode = !_isDarkMode;
    await hiveService.setIsDaskMode(_isDarkMode);
    notifyListeners();
  }

  ThemeData get theme => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}