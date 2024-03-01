import 'package:codelap/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildImageContainer(),
                      buildTextContainer(),
                      nameTextField(),
                      emailTextField(),
                      passwordTextField(),
                      buildText(),
                      buildElipse(),
                      signInText(),
                      button()
                    ],
                  ),
                ),
              )
            ],
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
        "Create\nAccount",
        style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            decorationColor: CustomColors.purpleColor,
          ),
        ),
      ),
    );
  }

  Transform nameTextField() {
    return Transform.translate(
      offset: const Offset(0, -100),
      child: SizedBox(
        width: 300,
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: const TextStyle(color: CustomColors.salt),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform emailTextField() {
    return Transform.translate(
      offset: const Offset(0, -70),
      child: SizedBox(
        width: 300,
        child: TextField(
          obscureText: true,
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
        child: TextField(
          obscureText: true,
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
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform buildText() {
    return Transform.translate(
      offset: const Offset(-100, 10),
      child: Text(
        "Sign Up",
        style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Transform buildElipse() {
    return Transform.translate(
      offset: const Offset(85, -47),
      child: Column(
        children: [
          Image.asset(
            'assets/elipse_two.png',
          ),
        ],
      ),
    );
  }

  Transform signInText() {
    return Transform.translate(
      offset: const Offset(120, -125),
      child: Text(
        "Sign In",
        style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Transform button() {
    return Transform.translate(
      offset: const Offset(110, -330),
      child: Container(
        width: 90.0,
        height: 100.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.purpleColor,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () {},
          child: const Center(
            child: Icon(FontAwesomeIcons.arrowRightLong),
          ),
        ),
      ),
    );
  }
}
