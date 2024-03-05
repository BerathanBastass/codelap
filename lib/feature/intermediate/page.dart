import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/homepage/home_page.dart';
import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: t1,
                  decoration: const InputDecoration(
                    hintText: 'İsim ve Soyisim',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 17,
                  controller: t2,
                  decoration: const InputDecoration(
                    hintText: 'Telefon (+90 555 555 5555)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    if (value.length < 17) {
                      return 'Phone number must include the country code';
                    }

                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        veriEkle();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thank You!!! Saved successfully.'),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomepageScreen(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.salt,
                    ),
                    child: const Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  veriEkle() {
    FirebaseFirestore.instance
        .collection('Profıl')
        .doc('Baslik')
        .set({'Name': t1.text, 'Phone': t2.text});
  }
}
