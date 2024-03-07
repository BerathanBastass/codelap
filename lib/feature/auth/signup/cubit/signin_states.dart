import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class NavigateToHomeState extends AuthState {}

class EmailVerificationState extends AuthState {
  final bool isVerified;

  EmailVerificationState(this.isVerified);

  @override
  List<Object?> get props => [isVerified];
}
