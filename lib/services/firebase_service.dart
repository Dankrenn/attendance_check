import 'package:attendance_check/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Получить текущего пользователя
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Регистрация пользователя
  Future<User?> register(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      throw Exception("Пользователь с таким email уже существует");
    } catch (e) {
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // await sendVerificationEmail();
        return result.user;
      } catch (e) {
        throw Exception("Ошибка при регистрации пользователя: ${e.toString()}");
      }
    }
  }

  // Вход в систему
  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if (!result.user!.emailVerified) {
      //   throw Exception("Пожалуйста, подтвердите свой email");
      // }
      return result.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw Exception("Пользователя не существует");
        } else if (e.code == 'wrong-password') {
          throw Exception("Неверный пароль");
        }
      }
      throw Exception("Ошибка при входе пользователя: ${e.toString()}");
    }
  }

  // // Отправить письмо для подтверждения email
  // Future<void> sendVerificationEmail() async {
  //   User? user = _auth.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //   }
  // }
  //
  // // Проверка подтверждения email
  // Future<bool> isEmailVerified() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     await user.reload();
  //     return user.emailVerified;
  //   }
  //   return false;
  // }

  // Сохранить данные пользователя
  Future<void> saveUserData(UserApp userApp) async {
    User? user = getCurrentUser();
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': userApp.name,
        'surname': userApp.surname,
        'email': userApp.email,
        'phoneNumber': userApp.phoneNumber,
        'group': userApp.group,
        'rule': userApp.rule,
      });
    }
  }

  // Загрузить данные пользователя
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = getCurrentUser();
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return doc.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      throw Exception("Ошибка при загрузке данных пользователя: ${e.toString()}");
    }
    return null;
  }

  // Выход из аккаунта
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Ошибка при выходе из аккаунта: ${e.toString()}");
    }
  }

  // Получить данные пользователя (роль или группу)
  Future<String?> getUserField(String field) async {
    try {
      final data = await getUserData();
      return data?[field];
    } catch (e) {
      throw Exception('Ошибка при получении данных пользователя: $e');
    }
  }

  // Метод для получения всех дисциплин по группе
  Future<List<Map<String, dynamic>>?> getAllDisciplines(String speciality) async {
    try {
      String collectionName = speciality.split('-')[0];
      QuerySnapshot querySnapshot = await _firestore
          .collection('disciplines')
          .doc('discipline')
          .collection(collectionName)
          .get();

      List<Map<String, dynamic>> disciplines = querySnapshot.docs.map((doc) {
        debugPrint('Document data: ${doc.data()}');
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return disciplines;
    } catch (e) {
      throw Exception('Ошибка при получении дисциплин: $e');
    }
  }

  // Метод для получения всех пользователей по группе
  Future<List<Map<String, dynamic>>?> getAllUsers(String group) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('group', isEqualTo: group)
          .get();

      List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return users;
    } catch (e) {
      debugPrint('Ошибка при получении пользователей: $e');
      throw Exception('Ошибка при получении пользователей: $e');
    }
  }


  // Метод для получения расписания конкретной группы
  Future<List<Map<String, dynamic>>?> getScheduleForGroup(String group) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('schedules')
          .where('group', isEqualTo: group)
          .get();

      List<Map<String, dynamic>> schedules = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return schedules;
    } catch (e) {
      debugPrint('Ошибка при получении расписания: $e');
      throw Exception('Ошибка при получении расписания: $e');
    }
  }

  // Метод для получения расписания по ФИО преподователя
  Future<List<Map<String, dynamic>>?> getScheduleForFullnameTeacher(String fullName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('schedules')
          .where('fullNameTeacher', isEqualTo: fullName)
          .get();

      List<Map<String, dynamic>> schedules = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return schedules;
    } catch (e) {
      debugPrint('Ошибка при получении расписания: $e');
      throw Exception('Ошибка при получении расписания: $e');
    }
  }

  // Метод для сохранения статуса пользователей в Firestore
  Future<void> saveUserStatusToFirestore(
      String userGroup, String subject, String date, DateTime classTime, List<UserApp> users, Map<String, String> userStatus) async {
    for (var user in users) {
      await _firestore
          .collection('magazine')
          .doc(userGroup)
          .collection(subject)
          .doc(date)
          .collection(classTime.toString())
          .doc(user.email)
          .set({
        'status': userStatus[user.email],
      });
    }
  }

  // Метод для загрузки статуса пользователей из Firestore
  Future<Map<String, String>> loadUserStatusFromFirestore(String userGroup, String subject, DateTime classTime, List<UserApp> users) async {
    Map<String, String> userStatus = {};
    try {
      final date = classTime.toString().split(' ')[0].replaceAll('-', ' ');
      final classTimeStr = classTime.toString();

      for (var user in users) {
        var doc = await _firestore
            .collection('magazine')
            .doc(userGroup)
            .collection(subject)
            .doc(date)
            .collection(classTimeStr)
            .doc(user.email)
            .get();

        if (doc.exists) {
          userStatus[user.email] = doc.data()?['status'] ?? '+';
        } else {
          userStatus[user.email] = '+';
        }
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке данных о посещаемости: $e');
    }
    return userStatus;
  }


}
