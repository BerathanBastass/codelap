import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildImageContainer(),
                    buildTextContainer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildImageContainer() {
    return Column(
      children: [
        Image.asset(
          'assets/elipse.jpg',
        ),
      ],
    );
  }

  Text buildTextContainer() {
    return Text("BERATHAN",
        style: GoogleFonts.hiMelody(
            textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )));
  }
}
