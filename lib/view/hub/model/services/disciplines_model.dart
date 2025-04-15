import 'package:attendance_check/models/discipline.dart';
import 'package:attendance_check/services/firebase_service.dart';
import 'package:flutter/material.dart';

class DisciplinesModel extends ChangeNotifier {
  String  _userGroup = '';
  late List<Discipline> _disciplines;
  bool _isLoading = true;
  FirebaseService firebaseService = FirebaseService();

  DisciplinesModel() {
    _disciplines = [];
    getDisciplines();
  }

  Future<void> getDisciplines() async {
    try {
      _isLoading = true;
      notifyListeners();

      _userGroup = (await firebaseService.getUserField('group'))!;
      final data = await firebaseService.getAllDisciplines(_userGroup);
      if (data != null) {
        _disciplines = data.map((doc) {
          return Discipline(
            title: doc['title'] ?? '',
            hours: doc['hours'] ?? 0,
            assessmentType: Discipline.assessmentTypeFromString(doc['assessmentType'] ?? ''),
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке дисциплин: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  List<Discipline> get disciplines => _disciplines;
  bool get isLoading => _isLoading;
}
