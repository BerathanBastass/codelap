import 'package:codelap/feature/auth/sign%C4%B1n/cubit/sign_n_cubit_state.dart';
import 'package:codelap/feature/auth/signup/view/signup_screens.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/splash.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/sign_n_cubit_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email = '';
  late String password = '';
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.purpleColor,
      body: BlocListener<SignInCubit, SignInAuthState>(
        listener: (context, state) {
          if (state is SignInSuccesssState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashPage()),
            );
          } else if (state is AuthErrorsState) {
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
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  elipseAsset(),
                  elipsePurple(),
                  buildTextContainer(),
                  emailTextField(),
                  passwordTextField(),
                  buildText(),
                  elipseWhite(),
                  forgotPassword(),
                  button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Transform elipseAsset() {
    return Transform.translate(
      offset: const Offset(-79, -0),
      child: Column(
        children: [
          Image.asset(
            'assets/signup_elipse.png',
          ),
        ],
      ),
    );
  }

  Transform elipsePurple() {
    return Transform.translate(
      offset: const Offset(200, -90),
      child: Column(
        children: [
          Image.asset(
            'assets/signup_yellow.png',
          ),
        ],
      ),
    );
  }

  Transform buildTextContainer() {
    return Transform.translate(
      offset: const Offset(-30, -300),
      child: Text(
        "Welcome Back",
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

  Transform elipseWhite() {
    return Transform.translate(
      offset: const Offset(90, -80),
      child: Column(
        children: [
          Image.asset(
            'assets/elipse_two.png',
          ),
        ],
      ),
    );
  }

  Transform emailTextField() {
    return Transform.translate(
      offset: const Offset(0, -200),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Your Email',
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
            email = value!;
          },
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform passwordTextField() {
    return Transform.translate(
      offset: const Offset(0, -180),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Password',
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
            password = value!;
          },
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform buildText() {
    return Transform.translate(
      offset: const Offset(-100, -150),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
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
          "Sign Up",
          style: GoogleFonts.rem(
            textStyle: const TextStyle(
              fontSize: 35,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Transform button() {
    return Transform.translate(
      offset: const Offset(120, -410),
      child: Container(
        width: 90.0,
        height: 100.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.pageColor,
        ),
        child: GestureDetector(
          onTap: () {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              context.read<SignInCubit>().signInAuth(email, password);
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

  Transform forgotPassword() {
    return Transform.translate(
        offset: const Offset(100, -210),
        child: TextButton(
          onPressed: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Container(
                width: 150,
                height: 5,
                color: CustomColors.pageColor,
              ),
            ],
          ),
        ));
  }
}
