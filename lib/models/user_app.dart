enum Rule {
  student,
  teacher,
  headman,
}

class UserApp {
  late String _name;
  late String _surname;
  late String _email;
  late String _phoneNumber; // Add this field
  late String _group;
  late Rule _rule = Rule.student;

  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  String get phoneNumber => _phoneNumber; // Getter for phone number
  String get group => _group;

  String get rule {
    return _rule == Rule.student
        ? 'Студент'
        : _rule == Rule.headman
        ? 'Староста'
        : 'Преподователь';
  }

  void setName(String value) {
    _name = value;
  }

  void setSurname(String value) {
    _surname = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  void setGroup(String value) {
    _group = value;
  }

  void setRule(String value) {
    _rule = value == 'Студент'
        ? Rule.student
        : value == 'Староста'
        ? Rule.headman
        : Rule.teacher;
  }
}
