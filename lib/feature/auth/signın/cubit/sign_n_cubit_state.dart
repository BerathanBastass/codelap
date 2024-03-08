import 'package:equatable/equatable.dart';

class SignInAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialsState extends SignInAuthState {}

class SignInSuccesssState extends SignInAuthState {}

class AuthErrorsState extends SignInAuthState {
  final String errorMessage;

  AuthErrorsState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class NavigateToHomeState extends SignInAuthState {}

// Yeni eklenen state
class VerificationEmailSentState extends SignInAuthState {}

class EmailNotVerifiedState extends SignInAuthState {}

class CheckEmailVerification extends SignInAuthState {}
