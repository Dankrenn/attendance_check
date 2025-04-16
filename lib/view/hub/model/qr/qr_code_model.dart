import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:flutter/material.dart';
import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';


class QrCodeModel extends ChangeNotifier {
  late UserApp _userApp;
  final FirebaseService firebaseService = FirebaseService();
  bool _isLoading = true;
  bool _isTeacher = false;
  List<SubjectSchedule> _list = [];

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final String _teacherSurname = 'Иванов В.В.';

  QrCodeModel() {
    _userApp = UserApp();
    getUserRoleAndSchedule();
  }

  bool get isLoading => _isLoading;
  bool get isTeacher => _isTeacher;
  List<SubjectSchedule> get list => _list;
  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  Future<void> getUserRoleAndSchedule() async {
    try {
      final role = await firebaseService.getUserField('rule');
      if (role != null) {
        _userApp.setRule(role);
        _isTeacher = role == "Преподаватель";
        if (_isTeacher) {
          await getTeacherSchedule();
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTeacherSchedule() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await firebaseService.getScheduleForFullnameTeacher(_teacherSurname);
      if (data != null) {
        _list = data.map((doc) {
          return SubjectSchedule(
            titleSubject: doc['titleSubject'] ?? '',
            typeActivity: doc['typeActivity'] ?? '',
            fullNameTeacher: doc['fullNameTeacher'] ?? '',
            group: doc['group'] ?? '',
            subgroup: doc['subgroup'] ?? '',
            numberAudit: doc['numberAudit'] ?? 0,
            classTime: DateTime.parse(doc['classTime']),
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке расписания: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  List<SubjectSchedule> getSchedulesForDay(DateTime day) {
    return _list.where((schedule) =>
    schedule.classTime.year == day.year &&
        schedule.classTime.month == day.month &&
        schedule.classTime.day == day.day
    ).toList();
  }

  void goQrGeneration(BuildContext context){
    context.push(NavigatorRouse.qrGeneration);
  }

  String _qrCodeResult = '';

  String get qrCodeResult => _qrCodeResult;

  void setQrCodeResult(String result) {
    _qrCodeResult = result;
    notifyListeners();
  }
}
