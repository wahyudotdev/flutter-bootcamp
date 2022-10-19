import 'package:flutter/material.dart';
import 'package:week2_state_manager/data/api.dart';
import 'package:week2_state_manager/ui/home/home_screen.dart';
import 'package:week2_state_manager/ui/menu_screen.dart';

import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final etEmailController = TextEditingController();
  final etPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final api = ApiImpl();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 2 - State Manager'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            title: 'Email',
            controller: etEmailController,
          ),
          AppTextField(
            title: 'Password',
            controller: etPasswordController,
          ),
          AppButton(
            caption: 'Login',
            onClick: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MenuScreen())),
          )
        ],
      ),
    );
  }
}
