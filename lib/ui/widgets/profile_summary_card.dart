import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_project/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({super.key, this.enableOnTap = true});

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  Uint8List imageBytes =
      Base64Decoder().convert(AuthController.user?.photo ?? '');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enableOnTap == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: AuthController.user?.photo == null
            ? const Icon(Icons.person)
            : ClipRRect(
              borderRadius: BorderRadius.circular(100),
                child: Image.memory(imageBytes, fit: BoxFit.cover,),
              ),
      ),
      title: Text(
        getFullName(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }

  String getFullName() {
    String firstName = AuthController.user?.firstName ?? '';
    String lastName = AuthController.user?.lastName ?? '';
    return '$firstName $lastName';
  }
}
