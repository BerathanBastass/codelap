import 'package:codelap/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/applocalizations/app_localizations.dart';

class AdvertDetail extends StatefulWidget {
  final String ilanID;

  const AdvertDetail({super.key, required this.ilanID});

  @override
  State<AdvertDetail> createState() => _AdvertDetailState();
}

class _AdvertDetailState extends State<AdvertDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.pageColor,
        title: Text(AppLocalizations.of(context).translate('İlanDetay')),
      ),
      backgroundColor: CustomColors.pageColor,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Ilanlar')
            .doc(widget.ilanID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          var data = snapshot.data?.data() as Map<String, dynamic>;
          var baslik = data['baslik'] ?? '';
          var fiyat = data['fiyat'] ?? '';
          var tur = data['tur'] ?? '';
          var aciklama = data['aciklama'] ?? '';
          var email = data['email'] ?? '';
          var ilanResimURL = data['image'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  ilanResimURL,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Text(
                  '$baslik',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  ' ${AppLocalizations.of(context).translate('Açıklama')}: $aciklama',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  ' ${AppLocalizations.of(context).translate('Tür')}: $tur',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  ' ${AppLocalizations.of(context).translate('Fiyat')}: $fiyat',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 50),
                Text(
                  ' ${AppLocalizations.of(context).translate('İlanSahibiBilgileri')}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Mail: $email',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
