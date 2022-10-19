import 'package:flutter/material.dart';
import 'package:week2_state_manager/ui/widgets/app_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton(
        caption: 'Logout email@gmail.com',
        onClick: () => null,
      ),
    );
  }
}
