import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileModel extends ChangeNotifier {
  late UserApp _userApp;
  bool isLoading = true;  // Состояние загрузки
  FirebaseService firebaseService = FirebaseService();

  ProfileModel() {
    _userApp = UserApp();
    getUser();
  }

  Future<void> getUser() async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await firebaseService.getUserData();
      if (data != null) {
        _userApp.setName(data['name'] ?? '');
        _userApp.setSurname(data['surname'] ?? '');
        _userApp.setPhoneNumber(data['phoneNumber'] ?? '');
        _userApp.setEmail(data['email'] ?? '');
        _userApp.setGroup(data['group'] ?? '');
        _userApp.setRule(data['rule'] ?? '');
      }
    } catch (e) {
      print("Ошибка при загрузке данных пользователя: $e");
    } finally {
      isLoading = false;  // Завершаем загрузку
      notifyListeners();  // Обновляем UI
    }
  }

  String get name => ('${_userApp.name} ${_userApp.surname}').toString();

  String get group => _userApp.group.toString();

  String get rule => _userApp.rule;

  String get email => _userApp.email;

  String get phoneNumber => _userApp.phoneNumber;

  void exit(BuildContext context) {
    firebaseService.logout();
    context.go(NavigatorRouse.avtoriz);
  }
}
