
class SubjectSchedule{

  late final String _title_subject;
  late final String _type_activity;
  late final String _full_name_teacher;
  late final String _subgroup;
  late final int _number_audit;
  late final DateTime _class_time;

  SubjectSchedule({
    required String titleSubject,
    required String typeActivity,
    required String fullNameTeacher,
    required String subgroup,
    required int numberAudit,
    required DateTime classTime,
  }) {
    _title_subject = titleSubject;
    _type_activity = typeActivity;
    _full_name_teacher = fullNameTeacher;
    _subgroup = subgroup;
    _number_audit = numberAudit;
    _class_time = classTime;
  }

  String get titleSubject => _title_subject;
  set titleSubject(String title) {
    _title_subject = title;
  }

  String get typeActivity => _type_activity;
  set typeActivity(String type) {
    _type_activity = type;
  }


  String get fullNameTeacher => _full_name_teacher;
  set fullNameTeacher(String name) {
    _full_name_teacher = name;
  }

  String get subgroup => _subgroup;
  set subgroup(String subgroup) {
    _subgroup = subgroup;
  }

  int get numberAudit => _number_audit;
  set numberAudit(int number) {
    _number_audit = number;
  }

  DateTime get classTime => _class_time;
  set classTime(DateTime time) {
    _class_time = time;
  }
}

