import 'package:codelap/feature/auth/sign%C4%B1n/view/sign%C4%B1n_screens.dart';
import 'package:codelap/feature/homepage/home_page.dart';
import 'package:codelap/feature/intermediate/intermediate_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/auth/forgot_password/cubit/cubit/fpassword_cubit_cubit.dart';
import 'feature/auth/signup/cubit/signin_cubit.dart';
import 'feature/auth/signın/cubit/sign_n_cubit_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(),
        ),
        BlocProvider<PasswordResetCubit>(
          create: (context) => PasswordResetCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SignInScreen(),
      routes: {
        "/homePage": (context) => const HomepageScreen(),
      },
    );
  }
}
