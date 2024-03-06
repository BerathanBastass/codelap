import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/colors.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: CustomColors.purpleColor,
        title: const Text(
          "Profil",
          style: TextStyle(fontSize: 25),
        ),
      ),
      backgroundColor: CustomColors.salt,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    assetCodeLab(),
                    const SizedBox(height: 20),
                    nameTextField(),
                    const SizedBox(height: 20),
                    phoneTextField(),
                    const SizedBox(height: 70),
                    button(),
                  ],
                ),
              ),
            ),
    );
  }

  SizedBox assetCodeLab() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 160.0, // İhtiyaca göre ayarlayabilirsiniz
      child: Image.asset(
        "assets/codelab_logo_2.png",
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding nameTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 300,
          child: TextFormField(
            controller: t1,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(color: CustomColors.purpleColor),
              filled: true,
              fillColor: Colors.black.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(FontAwesomeIcons.user),
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
      ),
    );
  }

  Padding phoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 300,
          child: TextFormField(
            controller: t2,
            decoration: InputDecoration(
              hintText: 'Phone',
              hintStyle: const TextStyle(color: CustomColors.purpleColor),
              filled: true,
              fillColor: Colors.black.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(FontAwesomeIcons.pencil),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  ElevatedButton button() {
    return ElevatedButton(
      onPressed: () {
        veriEkle();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: CustomColors.saltWhite,
      ),
      child: const Text(
        'Kaydet',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  veriEkle() {
    FirebaseFirestore.instance
        .collection('Profıl')
        .doc('Baslik')
        .set({'Name': t1.text, 'Phone': t2.text});
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Profıl')
          .doc('Baslik')
          .get();

      var data = documentSnapshot.data() as Map<String, dynamic>? ?? {};
      var email = data['Name'] as String? ?? '';
      var phone = data['Phone'] as String? ?? '';

      t1.text = email;
      t2.text = phone;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
}
