import 'package:attendance_check/view/hub/view/qr_code_scan_view.dart';
import 'package:attendance_check/view/hub/view/services_view.dart';
import 'package:attendance_check/view/hub/view/profile_view.dart';
import 'package:flutter/material.dart';

class HubModel extends ChangeNotifier{
  int _currentIndex = 1;
  final List<Widget> _tabs = [
    QrCodeScanView(),
    ServicesView(),
    ProfileView(),
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get tabs => _tabs;


  void updateCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}