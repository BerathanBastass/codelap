import 'package:codelap/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/cubit/fpassword_cubit_cubit.dart';

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
      body: BlocProvider(
        create: (context) => ForgotPasswordCubit(),
        child: _ForgotPasswordScreenContent(),
      ),
    );
  }
}

class _ForgotPasswordScreenContent extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              elipsePurple(),
              elipseWhite(),
              button(context),
              emailTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget elipsePurple() {
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

  Widget elipseWhite() {
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

  Widget emailTextField(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, -450),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            helperText:
                "Geben Sie Ihre E-Mail-Adresse ein, um Ihr Passwort zurückzusetzen",
            hintStyle: const TextStyle(color: CustomColors.salt),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {}
            return null;
          },
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
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
            context
                .read<ForgotPasswordCubit>()
                .resetPassword(emailController.text);
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
