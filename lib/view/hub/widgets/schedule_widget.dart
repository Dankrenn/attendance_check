import 'package:attendance_check/models/subject_schedule.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final SubjectSchedule schedule;

  const ScheduleWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              '${schedule.classTime.hour}:${schedule.classTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              schedule.titleSubject,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.meeting_room, size: 18),
                SizedBox(width: 8),
                Text(
                  'Аудитория: ${schedule.numberAudit}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 18),
                SizedBox(width: 8),
                Text(
                  'Преподаватель: ${schedule.fullNameTeacher}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.group, size: 18),
                SizedBox(width: 8),
                Text(
                  'Подгруппа: ${schedule.subgroup}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}