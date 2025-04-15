import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:go_router/go_router.dart';

class AddInfoInAccountModel extends ChangeNotifier {
  final UserApp _userApp;
  final FirebaseService _firebaseService;

  AddInfoInAccountModel(this._userApp, this._firebaseService) {
    loadUserData();
  }

  String get email => _userApp.email;
  String get name => _userApp.name;
  String get surname => _userApp.surname;
  String get phoneNumber => _userApp.phoneNumber;
  String? get group => _userApp.group;
  String get userType => _userApp.rule;

  void setName(String value) {
    _userApp.setName(value);
    notifyListeners();
  }

  void setSurname(String value) {
    _userApp.setSurname(value);
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _userApp.setPhoneNumber(value);
    notifyListeners();
  }

  void setGroup(String value) {
    _userApp.setGroup(value);
    notifyListeners();
  }

  void setUserType(String value) {
    _userApp.setRule(value);
    notifyListeners();
  }

  void loadUserData() {
    User? user = _firebaseService.getCurrentUser();
    if (user != null) {
      _userApp.setEmail(user.email!);
      notifyListeners();
    }
  }

  void _goBack(BuildContext context){
    context.go(NavigatorRouse.avtoriz);
  }

  Future<void> saveUserData() async {
    await _firebaseService.saveUserData(_userApp);
  }

  bool validateAndSave(BuildContext context) {
    if (_userApp.name.isEmpty ||
        _userApp.surname.isEmpty ||
        _userApp.phoneNumber.isEmpty ||
        _userApp.group == null) {
      return false;
    }
    saveUserData();
    _goBack(context);
    return true;
  }
}
