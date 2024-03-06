import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/intermediate/page.dart';

import 'package:flutter/material.dart';

class Infos extends StatefulWidget {
  const Infos({super.key});

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.purpleColor,
      appBar: AppBar(
        leading: null,
        backgroundColor: CustomColors.purpleColor,
        title: const Text("Hangisi Olmak İstiyorsun?"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(
              title: 'Yazılımcı',
              imagePath: "assets/developer.jpeg",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home2()),
                );
              },
            ),
            const SizedBox(height: 40),
            CardWidget(
              title: 'Müşteri',
              imagePath: "assets/customer_png.png",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String imagePath; // Yeni eklenen özellik: Resim yolu
  final VoidCallback onTap;

  // Yeni eklenen parametre constructor'a eklendi
  const CardWidget(
      {required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 100,
        child: Container(
          color: Colors.white,
          width: 350,
          height: 300,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 300,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
