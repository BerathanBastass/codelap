import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signin_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitialState());

  void signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = _auth.currentUser;
      await user?.sendEmailVerification();

      emit(SignUpSuccessState());
    } catch (e) {
      emit(AuthErrorState("Error during sign up: $e"));
    }
  }

  Future<void> checkEmailVerificationAndNavigate() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.reload();
        user = _auth.currentUser;

        if (user!.emailVerified) {
          emit(EmailVerificationState(true));
          emit(NavigateToHomeState());
        } else {
          emit(EmailVerificationState(false));
        }
      }
    } catch (e) {
      emit(AuthErrorState("Error during email verification: $e"));
    }
  }
}
