import 'package:flutter/material.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person_2_rounded),
      ),
      title: Text(
        'Rabbil Hasan',
        style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        'rubbil@gmail.com',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Icon(Icons.arrow_forward),
      tileColor: Colors.green,
    );
  }
}