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
      emit(SignUpSuccessState());

      // Başarılı kayıt işleminden sonra sayfaya yönlendirme
      emit(NavigateToHomeState()); // Yeni state tanımlanmalı
    } catch (e) {
      emit(AuthErrorState("Error during sign up: $e"));
    }
  }
}
