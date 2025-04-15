import 'package:attendance_check/main.dart';
import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/view/entrance/view/add_info_in_account_view.dart';
import 'package:attendance_check/view/entrance/view/auth_view.dart';
import 'package:attendance_check/view/entrance/view/registr_view.dart';
import 'package:attendance_check/view/hub/view/hub_view.dart';
import 'package:attendance_check/view/hub/view/services/disciplines_view.dart';
import 'package:attendance_check/view/hub/view/services/group_list_view.dart';
import 'package:attendance_check/view/hub/view/services/instructions_view.dart';
import 'package:attendance_check/view/hub/view/services/magazine/magazine_view.dart';
import 'package:attendance_check/view/hub/view/profile_view.dart';
import 'package:attendance_check/view/hub/view/services/magazine/tag_user_view.dart';
import 'package:attendance_check/view/hub/view/services/schedule_view.dart';
import 'package:attendance_check/view/hub/view/services/settings_view.dart';
import 'package:go_router/go_router.dart';

abstract class NavigatorRouse {
  static const String hub = "/hub";
  static const String register = "/register";
  static const String avtoriz = "/avtoriz";
  static const String profile = "/hub/profile";
  static const String schedule = "/hub/schedule";
  static const String instructions = "/hub/instructions";
  static const String groupList = "/hub/groupList";
  static const String disciplines = "/hub/disciplines";
  static const String settings = "/hub/settings";
  static const String magazine = "/hub/magazine";
  static const String tagUser = "/hub/magazine/subjectDetail";
}

class NavigatorApp {
  static final NavigatorApp _instance = NavigatorApp._internal();
  static final GoRouter _router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(path: NavigatorRouse.hub, builder: (context, state) => HubView()),
      GoRoute(path: NavigatorRouse.register, builder: (context, state) => RegistrView()),
      GoRoute(path: NavigatorRouse.avtoriz, builder: (context, state) => AuthView()),
      GoRoute(path: NavigatorRouse.profile, builder: (context, state) => AddInfoInAccountView()),
      GoRoute(path: NavigatorRouse.schedule, builder: (context, state) => ScheduleView()),
      GoRoute(path: NavigatorRouse.instructions, builder: (context, state) => InstructionsView()),
      GoRoute(path: NavigatorRouse.groupList, builder: (context, state) => GroupListView()),
      GoRoute(path: NavigatorRouse.disciplines, builder: (context, state) => DisciplinesView()),
      GoRoute(path: NavigatorRouse.settings, builder: (context, state) => SettingsView()),
      GoRoute(path: NavigatorRouse.magazine, builder: (context, state) => MagazineView()),
      GoRoute(
        path: NavigatorRouse.tagUser,
        builder: (context, state) {
          final subject = state.extra as SubjectSchedule;
          return TagUserView(subject: subject);
        },
      ),
    ],
  );

  factory NavigatorApp() {
    return _instance;
  }

  NavigatorApp._internal();

  GoRouter get routerConfig => _router;
}

