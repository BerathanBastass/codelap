import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_n_cubit_state.dart';

class SignInCubit extends Cubit<SignInAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit() : super(AuthInitialsState());
  Future<bool> signInAuth(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccesssState());
      emit(NavigateToHomeState());
      return true;
    } catch (e) {
      emit(AuthErrorsState("Error during sign in: $e"));
      return false;
    }
  }

  void signUpAndSendVerificationEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();

        emit(VerificationEmailSentState());
      } else {
        emit(AuthErrorsState("User creation failed"));
      }
    } catch (e) {
      emit(AuthErrorsState("Error during sign up: $e"));
    }
  }

  void checkEmailVerification(String email, String password) async {
    User? user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      // E-posta doğrulama tamamlandı, kullanıcıyı içeri alabilirsiniz.
      emit(SignInSuccesssState());
      emit(NavigateToHomeState());
    } else {
      // E-posta doğrulama tamamlanmamışsa, kullanıcıyı uyarabilir veya başka bir işlem yapabilirsiniz.
      emit(EmailNotVerifiedState());
    }
  }
}
