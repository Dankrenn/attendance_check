import 'dart:async';
import 'package:flutter/material.dart';

class QrGeneretionModel extends ChangeNotifier {
  late Timer _timer;
  String _qrData = "Вы успешно отмечены на лекции";

  QrGeneretionModel() {
    _startTimer();
  }

  String get qrData => _qrData;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _qrData = "Вы успешно отмечены на лекции ${DateTime.now()}";
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
