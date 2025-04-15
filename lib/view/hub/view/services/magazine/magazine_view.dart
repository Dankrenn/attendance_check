import 'package:attendance_check/view/hub/model/services/magazine/magazine_model.dart';
import 'package:attendance_check/view/hub/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MagazineView extends StatelessWidget {
  const MagazineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MagazineModel>(
      create: (context) => MagazineModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MagazineModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Журнал"),
        centerTitle: true,
      ),
      body: model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: MagazineListWidget(),
      ),
    );
  }
}

class MagazineListWidget extends StatelessWidget {
  const MagazineListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MagazineModel>(context);
    return ListView.builder(
      itemCount: model.list.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            model.goTagUserView(context,index);
            debugPrint('Нажато');
          },
          child: ScheduleWidget(schedule: model.list[index]),
        );
      },
    );
  }
}
