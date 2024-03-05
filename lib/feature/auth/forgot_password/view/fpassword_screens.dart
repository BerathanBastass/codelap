import 'package:codelap/core/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot"),
        backgroundColor: CustomColors.purpleColor,
      ),
      backgroundColor: CustomColors.pageColor,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                elipsePurple(),
                elipseWhite(),
                button(),
                emailTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Transform elipsePurple() {
    return Transform.translate(
      offset: const Offset(200, -20),
      child: Column(
        children: [
          Image.asset(
            'assets/signup_yellow.png',
          ),
        ],
      ),
    );
  }

  Transform elipseWhite() {
    return Transform.translate(
      offset: const Offset(100, 140),
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
      offset: const Offset(-10, -450),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            helperText: "Şifrenizi sıfırlamak için e-postanızı girin.",
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
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Transform button() {
    return Transform.translate(
      offset: const Offset(120, -110),
      child: Container(
        width: 90.0,
        height: 100.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.purpleColor,
        ),
        child: GestureDetector(
          onTap: () {
            resetPassword();
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

  void resetPassword() async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Şifre sıfırlama e-postası gönderildi.",
              style: TextStyle(
                color: CustomColors.pageColor,
                fontSize: 20,
              ),
            ),
            backgroundColor: CustomColors.purpleColor,
            duration: Duration(seconds: 5),
          ),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Error: Unable to send password reset email.",
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
    }
  }
}
