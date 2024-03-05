import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/homepage/homepage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/codelab_logo.png'),
      logoWidth: 200,
      title: const Text(
        "Congratulations! Your user has been successfully created",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      backgroundColor: CustomColors.pageColor,
      showLoader: true,
      loadingText: const Text(
        "Welcome aboard my friend",
        style: TextStyle(fontSize: 20),
      ),
      navigator: const HomePage(),
      durationInSeconds: 5,
    );
  }
}
