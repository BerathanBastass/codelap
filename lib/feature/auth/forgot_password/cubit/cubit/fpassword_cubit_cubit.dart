import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'fpassword_cubit_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PasswordResetCubit() : super(PasswordResetInitial());

  Future<void> resetPassword(String email) async {
    emit(PasswordResetLoading());

    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(
          PasswordResetSuccess(message: "Password reset email has been sent."));
    } catch (e) {
      emit(PasswordResetError(
          error: "Error: Unable to send password reset email."));
    }
  }
}
