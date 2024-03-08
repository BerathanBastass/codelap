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

  const AuthErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class NavigateToHomeState extends AuthState {}

class EmailVerificationState extends AuthState {
  final bool isVerified;

  const EmailVerificationState(this.isVerified);

  @override
  List<Object?> get props => [isVerified];
}
