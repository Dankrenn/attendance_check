import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesModel extends ChangeNotifier {
  late UserApp _userApp;
  final FirebaseService firebaseService = FirebaseService();
  bool _isLoading = true;

  ServicesModel() {
    _userApp = UserApp();
    getUserRule();
  }

  bool get isLoading => _isLoading;

  Future<void> getUserRule() async {
    try {
      final role = await firebaseService.getUserField('rule');
      if (role != null) {
        _userApp.setRule(role);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void goSchedule(BuildContext context) {
    context.push(NavigatorRouse.schedule);
  }

  void goInstructions(BuildContext context) {
    context.push(NavigatorRouse.instructions);
  }

  void goGroupList(BuildContext context) {
    context.push(NavigatorRouse.groupList);
  }

  void goDisciplines(BuildContext context) {
    context.push(NavigatorRouse.disciplines);
  }

  void goSettings(BuildContext context) {
    context.push(NavigatorRouse.settings);
  }

  void goMagazine(BuildContext context) {
    context.push(NavigatorRouse.magazine);
  }

  bool get isStudentLeader {
    return _userApp.rule == "Староста";
  }

  bool get isTeacher {
    return _userApp.rule == "Преподователь";
  }
}
