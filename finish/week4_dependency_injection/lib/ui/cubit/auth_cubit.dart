import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:week4_dependency_injection/data/api.dart';
import 'package:week4_dependency_injection/models/user.dart';
import 'package:week4_dependency_injection/utils/status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._api) : super(AuthInitial());

  final Api _api;

  void login({required String email, required String password}) async {
    emit(const UserAuthState(status: Status.loading));
    try {
      final response = await _api.login(email, password);
      emit(UserAuthState(status: Status.success, data: response.data));
    } catch (e) {
      emit(UserAuthState(status: Status.error, message: e.toString()));
    }
  }

  void logout() {
    emit(UserLogoutState());
  }
}
