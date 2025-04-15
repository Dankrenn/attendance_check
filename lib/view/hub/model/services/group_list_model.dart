import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';

class GroupListModel extends ChangeNotifier{
  late List<UserApp> _users = [];

  String  _userGroup = '';
  bool _isLoading = true;
  FirebaseService firebaseService = FirebaseService();

  GroupListModel() {
    _users = [];
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      _isLoading = true;
      notifyListeners();

      _userGroup = (await firebaseService.getUserField('group'))!;
      final data = await firebaseService.getAllUsers(_userGroup);
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
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке пользователей: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<UserApp> get users => _users;
}