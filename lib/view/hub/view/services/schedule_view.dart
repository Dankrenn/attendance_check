import 'package:attendance_check/view/hub/model/services/schedule_model.dart';
import 'package:attendance_check/view/hub/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleModel>(
      create: (context) => ScheduleModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ScheduleModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Расписание"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarWidget(),
        model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
              child: ScheduleListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ScheduleModel>(context);

    return TableCalendar(
      locale: 'ru_RU',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: model.focusedDay,
      calendarFormat: model.calendarFormat,
      onDaySelected: model.onDaySelected,
      selectedDayPredicate: (day) {
        return isSameDay(model.selectedDay, day);
      },
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(fontSize: 18),
        formatButtonTextStyle: TextStyle(fontSize: 18),
      ),
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(fontSize: 18),
        weekendTextStyle: TextStyle(fontSize: 18),
        selectedTextStyle: TextStyle(fontSize: 18),
        todayTextStyle: TextStyle(fontSize: 18),
      ),
      daysOfWeekHeight: 40,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 18),
        weekendStyle: TextStyle(fontSize: 18),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Неделя',
      },
      onFormatChanged: model.onFormatChanged,
    );
  }
}

class ScheduleListWidget extends StatelessWidget {
  const ScheduleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ScheduleModel>(context);
    final filteredList = model.getSchedulesForDay(model.selectedDay);
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return ScheduleWidget(schedule: filteredList[index]);
      },
    );
  }
}
