import 'package:attendance_check/models/subject_schedule.dart';
import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/view/hub/model/services/magazine/tag_user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagUserView extends StatelessWidget {
  final SubjectSchedule subject;

  const TagUserView({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TagUserModel>(
      create: (context) => TagUserModel(subject),
      child: _SubjectDetailWidget(),
    );
  }
}

class _SubjectDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TagUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(model.subject.titleSubject),
        centerTitle: true,
      ),
      body: model.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          InfoSubject(),
          Expanded(
            child: ListView.builder(
              itemCount: model.users.length,
              itemBuilder: (BuildContext context, int index) {
                return TagUserWidget(user: model.users[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.saveUserStatus(context),
        child: Icon(Icons.send_outlined),
      ),
    );
  }
}

class TagUserWidget extends StatelessWidget {
  final UserApp user;

  const TagUserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TagUserModel>(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.surname} ${user.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildButtons(model, user.email),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(TagUserModel model, String userId) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          _buildButton('+', model, userId, Colors.green),
          _buildButton('Н', model, userId, Colors.red),
          _buildButton('У', model, userId, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildButton(
      String label, TagUserModel model, String userId, Color color) {
    return GestureDetector(
      onTap: () {
        model.updateUserStatus(userId, label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color:
            model.userStatus[userId] == label ? color : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(label),
      ),
    );
  }
}

class InfoSubject extends StatelessWidget {
  const InfoSubject({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TagUserModel>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Преподаватель: ${model.subject.fullNameTeacher}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Тип занятия: ${model.subject.typeActivity}',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Аудитория: ${model.subject.numberAudit} ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Время: ${model.subject.classTime.hour} : ${model.subject.classTime.minute}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Text(
            'Подгруппа: ${model.subject.subgroup}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
