import 'package:codelap/core/splash.dart';
import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/auth/sign%C4%B1n/view/sign%C4%B1n_screens.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cubit/signin_cubit.dart';
import '../cubit/signin_states.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpscreen> {
  late String email = '';
  late String password = '';
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SplashPage()),
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Error Message: Enter Email and Password format correctly!",
                  style: TextStyle(
                    color: CustomColors.pageColor,
                    fontSize: 20,
                  ),
                ),
                backgroundColor: CustomColors.purpleColor,
                duration: Duration(seconds: 5),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildImageContainer(),
                        buildTextContainer(),
                        emailTextField(),
                        passwordTextField(),
                        buildText(),
                        buildElipse(),
                        button(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Transform buildImageContainer() {
    return Transform.translate(
      offset: const Offset(-10, -1),
      child: Column(
        children: [
          Image.asset(
            'assets/elipse.png',
          ),
        ],
      ),
    );
  }

  Transform buildTextContainer() {
    return Transform.translate(
      offset: const Offset(-70, -170),
      child: Text(
        "Hesap\nOluştur",
        style: GoogleFonts.rem(
          textStyle: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            decorationColor: CustomColors.purpleColor,
          ),
        ),
      ),
    );
  }

  Transform emailTextField() {
    return Transform.translate(
      offset: const Offset(0, -70),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(color: CustomColors.salt),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
          onSaved: (value) {
            email = value ?? '';
          },
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform passwordTextField() {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Sifre',
            helperText: "Must enter six values",
            hintStyle: const TextStyle(color: CustomColors.salt),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          onSaved: (value) {
            password = value ?? '';
          },
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform buildElipse() {
    return Transform.translate(
      offset: const Offset(85, 16),
      child: Column(
        children: [
          Image.asset(
            'assets/elipse_two.png',
          ),
        ],
      ),
    );
  }

  Transform buildText() {
    return Transform.translate(
      offset: const Offset(-80, -0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: CustomColors.pageColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(color: Colors.black, width: 5),
          ),
        ),
        child: Text(
          "Giriş Yap",
          style: GoogleFonts.rem(
            textStyle: const TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Transform button() {
    return Transform.translate(
      offset: const Offset(110, -280),
      child: Container(
        width: 90.0,
        height: 100.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.purpleColor,
        ),
        child: GestureDetector(
          onTap: () {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              context.read<AuthCubit>().signUp(email, password);
            }
          },
          child: InkResponse(
            borderRadius: BorderRadius.circular(50.0),
            child: const Center(
              child: Icon(FontAwesomeIcons.arrowRightLong),
            ),
          ),
        ),
      ),
    );
  }
}