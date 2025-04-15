import 'package:attendance_check/models/discipline.dart';
import 'package:attendance_check/view/hub/model/services/disciplines_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisciplinesView extends StatelessWidget {
  const DisciplinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DisciplinesModel>(
      create: (context) => DisciplinesModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DisciplinesModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Дисциплины"),
        centerTitle: true,
      ),
      body: model.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: model.disciplines.length,
        itemBuilder: (BuildContext context, int index) {
          return DisciplineViewWidget(discipline: model.disciplines[index]);
        },
      ),
    );
  }
}

class DisciplineViewWidget extends StatelessWidget {
  final Discipline discipline;

  const DisciplineViewWidget({super.key, required this.discipline});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              discipline.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Количество часов: ${discipline.hours}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 4),
            Text(
              'Тип оценивания: ${discipline.assessmentTypeString}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
