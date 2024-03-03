import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_n_cubit_state.dart';

class SignInCubit extends Cubit<SignInAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit() : super(AuthInitialsState());

  void signInAuth(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccesssState());
      emit(NavigateToHomeState());
    } catch (e) {
      emit(AuthErrorsState("Error during sign in: $e"));
    }
  }
}
