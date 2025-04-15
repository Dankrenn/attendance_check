import 'package:attendance_check/models/user_app.dart';
import 'package:attendance_check/view/hub/model/services/group_list_model.dart';
import 'package:attendance_check/view/hub/widgets/user_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupListModel>(
      create: (context) => GroupListModel(),
      child: _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GroupListModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Список группы"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: model.users.length, // Add itemCount
        itemBuilder: (BuildContext context, int index) {
          return UserViewWidget(user: model.users[index]);
        },
      ),
    );
  }
}
