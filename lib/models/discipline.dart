enum AssessmentType {
  credit,
  creditWithGrade,
  exam,
}

class Discipline {
  late final String _title;
  late final int _hours;
  late final AssessmentType _assessmentType;

  Discipline({
    required String title,
    required int hours,
    required AssessmentType assessmentType,
  }) {
    _title = title;
    _hours = hours;
    _assessmentType = assessmentType;
  }

  String get title => _title;
  set title(String title) {
    _title = title;
  }

  int get hours => _hours;
  set hours(int hours) {
    _hours = hours;
  }

  AssessmentType get assessmentType => _assessmentType;
  set assessmentType(AssessmentType type) {
    _assessmentType = type;
  }

  String get assessmentTypeString {
    return _assessmentType == AssessmentType.credit
        ? 'Зачет'
        : _assessmentType == AssessmentType.creditWithGrade
        ? 'Зачет с оценкой'
        : 'Экзамен';
  }

  // Метод для преобразования строки в тип аттестации
  static AssessmentType assessmentTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case "credit":
        return AssessmentType.credit;
      case "creditwithgrade":
        return AssessmentType.creditWithGrade;
      case "exam":
        return AssessmentType.exam;
      default:
        throw ArgumentError('Недопустимый тип аттестации: $type');
    }
  }
}
