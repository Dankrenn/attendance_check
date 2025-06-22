import 'package:attendance_check/services/firebase_service.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:attendance_check/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntranceModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _configPassword = '';
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  FirebaseService firebaseService = FirebaseService();

  String get email => _email;

  String get password => _password;

  String get configPassword => _configPassword;

  bool get showPassword => _showPassword;

  bool get showConfirmPassword => _showConfirmPassword;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _configPassword = value;
    notifyListeners();
  }

  void setShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void setShowConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }

  void _clearInfo() {
    _email = '';
    _password = '';
    _configPassword = '';
    _showPassword = false;
    _showConfirmPassword = false;
  }

  void goAuth(BuildContext context) {
    _clearInfo();
    context.push(NavigatorRouse.avtoriz);
  }

  void goRegistr(BuildContext context) {
    _clearInfo();
    context.push(NavigatorRouse.register);
  }

  void _goProfile(BuildContext context) {
    _clearInfo();
    context.go(NavigatorRouse.profile);
  }

  void _goHome(BuildContext context) {
    _clearInfo();
    context.go(NavigatorRouse.hub);
  }

  void authUser(BuildContext context) async {
    String? emailError = Validator.validateEmail(_email);
    String? passwordError = Validator.validatePassword(_password);

    if (emailError != null) {
      Validator.showError(context, emailError);
      return;
    }

    if (passwordError != null) {
      Validator.showError(context, passwordError);
      return;
    }

    try {
      User? user = await firebaseService.login(_email, _password);
      if (user != null) {
        _goHome(context);
      }
    } catch (e) {
      Validator.showError(context, e.toString());
    }
  }

  void registerUser(BuildContext context) async {
    String? emailError = Validator.validateEmail(_email);
    String? passwordError = Validator.validatePassword(_password);
    if(_password !=  _configPassword){
      Validator.showError(context, 'Пароли не совпадают');
      return;
    }
    if (emailError != null) {
      Validator.showError(context, emailError);
      return;
    }

    if (passwordError != null) {
      Validator.showError(context, passwordError);
      return;
    }

    try {
      User? user = await firebaseService.register(_email, _password);
      if (user != null) {
        _goProfile(context);
      }
    } catch (e) {
      Validator.showError(context, e.toString());
    }
  }
}
