import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key, this.enableOnTap = true
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if(enableOnTap==true){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          ),
        );
        }
      },
      leading: CircleAvatar(
        child: Icon(Icons.person_2_rounded),
      ),
      title: Text(
        'Rabbil Hasan',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
