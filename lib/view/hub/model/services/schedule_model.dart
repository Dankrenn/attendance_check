import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleModel extends ChangeNotifier {
  List<SubjectSchedule> _list = [];
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _isLoading = true;
  FirebaseService firebaseService = FirebaseService();
  String _userGroup = '';

  ScheduleModel() {
    _list = [];
    getSchedule();
  }

  Future<void> getSchedule() async {
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
            group: doc['group'] ?? '',
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

  List<SubjectSchedule> get list => _list;
  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  bool get isLoading => _isLoading;

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
}
