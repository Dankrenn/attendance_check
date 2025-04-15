import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MagazineModel extends ChangeNotifier {
  List<SubjectSchedule> _list = [];
  bool _isLoading = true;
  FirebaseService firebaseService = FirebaseService();
  String _userGroup = '';

  MagazineModel() {
    _list = [];
    getSchedule();
  }

  Future<List<SubjectSchedule>> getSchedule() async {
    try {
      _isLoading = true;
      notifyListeners();
      _userGroup = (await firebaseService.getUserField('group'))!;
      final data = await firebaseService.getScheduleForGroup(_userGroup);
      if (data != null) {
        _list = data.map((doc) {
          return SubjectSchedule(
            titleSubject: doc['titleSubject'] ?? '',
            typeActivity: doc['typeActivity'] ?? '',
            fullNameTeacher: doc['fullNameTeacher'] ?? '',
            subgroup: doc['subgroup'] ?? '',
            numberAudit: doc['numberAudit'] ?? 0,
            classTime: DateTime.parse(doc['classTime']),
          );
        }).toList();

        DateTime today = DateTime.now();
        return _list.where((schedule) {
          return schedule.classTime.year == today.year &&
              schedule.classTime.month == today.month &&
              schedule.classTime.day == today.day;
        }).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Ошибка при загрузке расписания: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<SubjectSchedule> get list => _list;

  bool get isLoading => _isLoading;

  List<SubjectSchedule> getSchedulesForDay() {
    DateTime day = DateTime.now();
    return _list.where((schedule) =>
    schedule.classTime.year == day.year &&
        schedule.classTime.month == day.month &&
        schedule.classTime.day == day.day
    ).toList();
  }

  void goTagUserView(BuildContext context, int index) {
    context.push(NavigatorRouse.tagUser, extra: list[index]);
  }
}