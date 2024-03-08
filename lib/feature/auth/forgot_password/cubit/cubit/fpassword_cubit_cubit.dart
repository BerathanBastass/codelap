import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fpassword_cubit_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  void resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      emit(ForgotPasswordSuccessState());
    } catch (e) {
      emit(ForgotPasswordErrorState(
          "Error: Unable to send password reset email."));
    }
  }
}
