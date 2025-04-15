import 'package:attendance_check/services/hive_service.dart';
import 'package:attendance_check/utils/navigator_app.dart';
import 'package:attendance_check/view/entrance/model/entrance_model.dart';
import 'package:attendance_check/view/hub/model/profile_model.dart';
import 'package:attendance_check/view/hub/model/services/setting_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

String initialRoute = NavigatorRouse.avtoriz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCUzrm-CYbAyoTFKGMSdLgpAWfTNbVxCKY',
          appId: '1:228678183603:android:3fbc4da831ec2b486e9ec6',
          messagingSenderId: '228678183603',
          projectId: 'attendence-check-3d68b'));

  await initializeDateFormatting('ru_RU', null);
  await HiveService().init();
  await initializeDateFormatting('ru_RU', null);
  await HiveService().init();

  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    initialRoute = NavigatorRouse.hub;
  } else {
    initialRoute = NavigatorRouse.avtoriz;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileModel>(
          create: (context) => ProfileModel(),
        ),
        ChangeNotifierProvider<SettingModel>(
          create: (context) => SettingModel(),
        ),
        ChangeNotifierProvider<EntranceModel>(
          create: (context) => EntranceModel(),
        ),
      ],
      child: Consumer<SettingModel>(
        builder: (context, settingModel, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: settingModel.theme,
            routerConfig: NavigatorApp().routerConfig,
          );
        },
      ),
    );
  }
}
