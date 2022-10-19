part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class UserAuthState extends AuthState {
  final Status status;
  final String? message;
  final User? data;

  const UserAuthState({
    required this.status,
    this.message,
    this.data,
  });
  @override
  List<Object?> get props => [status, message, data];
}
