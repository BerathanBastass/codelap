import 'package:equatable/equatable.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object?> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetSuccess extends PasswordResetState {
  final String message;

  PasswordResetSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasswordResetError extends PasswordResetState {
  final String error;

  PasswordResetError({required this.error});

  @override
  List<Object?> get props => [error];
}
