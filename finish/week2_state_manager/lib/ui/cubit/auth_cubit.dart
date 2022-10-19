import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:week2_state_manager/data/api.dart';
import 'package:week2_state_manager/models/user.dart';
import 'package:week2_state_manager/utils/status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._api) : super(AuthInitial());

  final Api _api;

  void login({required String email, required String password}) async {
    emit(const UserAuthState(status: Status.loading));
    try {
      final response = await _api.login(email, password);
      emit(UserAuthState(status: Status.success, data: response));
    } catch (e) {
      emit(UserAuthState(status: Status.error, message: e.toString()));
    }
  }

  void logout() {
    emit(UserLogoutState());
  }
}
