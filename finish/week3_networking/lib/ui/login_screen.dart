import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week3_networking/ui/cubit/auth_cubit.dart';
import 'package:week3_networking/utils/status.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserAuthState) {
          if (state.status == Status.loading) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Loading . .')));
          }
          if (state.status == Status.success) {
            context.go('/menu');
          }
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Week 3 - Networking'),
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
                onClick: () => context.read<AuthCubit>().login(
                      email: etEmailController.text,
                      password: etPasswordController.text,
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}
