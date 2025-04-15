import 'package:flutter/material.dart';

class InstructionsView extends StatelessWidget {
  const InstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Инструкция", style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Добро пожаловать в приложение!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "1. Регистрация и Авторизация",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "При первом запуске приложения вам нужно будет зарегистрироваться или авторизоваться. Следуйте инструкциям на экране, чтобы создать учетную запись или войти в существующую.",
                style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              "2. Главный экран",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "После успешной авторизации вы попадете на главный экран приложения. Здесь вы увидите несколько вкладок:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            const Text(
              "- Вкладка для сканирования QR-кода: Используйте её для отметки посещаемости.",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "- Вкладка с сервисами: Здесь вы можете просмотреть расписание, список своей группы, дисциплины и настроить приложение под себя.",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "- Журнал (для старост): Позволяет отмечать студентов вручную при возникновении ошибок.",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "- Личный профиль: Здесь вы можете просмотреть и редактировать информацию о себе, а также выйти из учетной записи.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              "3. Отметка посещаемости",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Для отметки посещаемости нажмите на вкладку сканирования QR-кода и наведите камеру на QR-код, предоставленный преподавателем. Приложение автоматически отметит ваше присутствие.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              "Если у вас возникнут вопросы или проблемы, обратитесь к администратору приложения.",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
