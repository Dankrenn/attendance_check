import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/service_card.dart';
import '../model/services_model.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ServicesModel>(
      create: (context) => ServicesModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ServicesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Сервисы'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.5,
          ),
          children: [
            ServiceCard(
              color: Colors.purple,
              icon: Icons.schedule,
              label: 'Расписания',
              onTap: () => model.goSchedule(context),
            ),
            ServiceCard(
              color: Colors.orange,
              icon: Icons.book,
              label: 'Инструкция',
              onTap: () => model.goInstructions(context),
            ),
            ServiceCard(
              color: Colors.green,
              icon: Icons.group,
              label: 'Список группы',
              onTap: () => model.goGroupList(context),
            ),
            ServiceCard(
              color: Colors.red,
              icon: Icons.assessment,
              label: 'Дисциплины',
              onTap: () => model.goDisciplines(context),
            ),
            ServiceCard(
              color: Colors.black12,
              icon: Icons.settings_outlined,
              label: 'Настройки',
              onTap: () => model.goSettings(context),
            ),
            if (model.isStudentLeader)
              ServiceCard(
                color: Colors.blue,
                icon: Icons.chrome_reader_mode_outlined,
                label: 'Журнал',
                onTap: () => model.goMagazine(context),
              ),
          ],
        ),
      ),
    );
  }
}
