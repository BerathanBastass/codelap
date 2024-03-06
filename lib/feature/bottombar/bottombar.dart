import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/advert/view/advert_view.dart';
import 'package:codelap/feature/homepage/view/home_page_screens.dart';
import 'package:codelap/feature/profile/view/profile_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItemPosition = 0;

  // Sayfa listesi
  final List<Widget> _pages = [
    const HomePageScreen(),
    const AdvertView(),
    const ProfileScreens()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      body: _pages[_selectedItemPosition], // Seçilen sayfayı göster
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(20),
        snakeViewColor: CustomColors.purpleColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimney),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plus),
            label: 'Oluştur',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userGear),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
