import 'package:attendance_check/models/user_app.dart';
import 'package:flutter/material.dart';

class UserViewWidget extends StatelessWidget {
  final UserApp user;

  const UserViewWidget({super.key, required this.user});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${user.surname} ${user.name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.rule,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Text(
              user.phoneNumber,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              user.email,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}