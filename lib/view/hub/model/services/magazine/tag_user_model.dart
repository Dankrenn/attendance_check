import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:flutter/material.dart';

class TagUserModel extends ChangeNotifier {
  final SubjectSchedule subject;
  List<UserApp> _users = [];
  bool _isLoading = true;
  FirebaseService firebaseService = FirebaseService();
  Map<String, String> userStatus = {};

  TagUserModel(this.subject) {
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userGroup = (await firebaseService.getUserField('group'))!;
      final data = await firebaseService.getAllUsers(userGroup);
      if (data != null) {
        _users = data.map((doc) {
          return UserApp()
            ..setName(doc['name'] ?? '')
            ..setSurname(doc['surname'] ?? '')
            ..setPhoneNumber(doc['phoneNumber'] ?? '')
            ..setEmail(doc['email'] ?? '')
            ..setGroup(doc['group'] ?? '')
            ..setRule(doc['rule'] ?? '');
        }).toList();

        // Инициализация статуса для всех пользователей
        for (var user in _users) {
          userStatus[user.email] = '+';
        }
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке пользователей: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<UserApp> get users => _users;
  bool get isLoading => _isLoading;

  void updateUserStatus(String userId, String status) {
    userStatus[userId] = status;
    notifyListeners();
  }

  Future<void> saveUserStatus() async {
    // try {
    //   for (var userId in _userStatus.keys) {
    //     await firebaseService.updateUserStatus(userId, _userStatus[userId]!);
    //   }
    //   // Показать сообщение об успешном сохранении
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Данные успешно сохранены')),
    //   );
    // } catch (e) {
    //   debugPrint('Ошибка при сохранении данных: $e');
    //   // Показать сообщение об ошибке
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Ошибка при сохранении данных')),
    //   );
    // }
  }
}
