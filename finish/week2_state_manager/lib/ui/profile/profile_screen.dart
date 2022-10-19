import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week2_state_manager/ui/cubit/auth_cubit.dart';
import 'package:week2_state_manager/ui/widgets/app_button.dart';
import 'package:week2_state_manager/utils/status.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is UserAuthState && state.status == Status.success) {
          return Center(
            child: AppButton(
              caption: 'Logout ${state.data?.email}',
              onClick: () => null,
            ),
          );
        }
        return Container();
      },
    );
  }
}
