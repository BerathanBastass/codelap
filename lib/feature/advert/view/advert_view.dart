import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/colors.dart';

class AdvertView extends StatefulWidget {
  const AdvertView({Key? key}) : super(key: key);

  @override
  _AdvertViewState createState() => _AdvertViewState();
}

class _AdvertViewState extends State<AdvertView> {
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();
  final TextEditingController _fiyatController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedType;

  // Seçilebilen 3 kelime
  final List<String> types = [
    'Mobil Uyguluma',
    'Web Sitesi',
    'Oyun Geliştirme'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ilan Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              headerTextField(),
              const SizedBox(height: 16),
              descriptionTextField(),
              const SizedBox(height: 16),
              priceTextField(),
              const SizedBox(height: 16),
              typeDropdown(),
              const SizedBox(height: 16),
              emailTextField(),
              const SizedBox(height: 16),
              imageTextField(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _ilanOlustur();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: CustomColors.saltWhite,
                ),
                child: const Text(
                  'Oluştur',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField headerTextField() {
    return TextFormField(
      controller: _baslikController,
      decoration: InputDecoration(
        hintText: 'Başlık',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the title';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
    );
  }

  TextFormField descriptionTextField() {
    return TextFormField(
      controller: _aciklamaController,
      decoration: InputDecoration(
        hintText: 'Açıklama',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the description';
        } else if (value.length < 30) {
          return 'Description should be at least 30 characters';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
    );
  }

  TextFormField priceTextField() {
    return TextFormField(
      controller: _fiyatController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(8),
      ],
      decoration: InputDecoration(
        hintText: 'Fiyat',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the price';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
    );
  }

  DropdownButtonFormField<String> typeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Dil',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      value: selectedType,
      items: types.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedType = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select the type';
        }
        return null;
      },
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
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
    );
  }

  TextFormField imageTextField() {
    return TextFormField(
      controller: _imageController,
      decoration: InputDecoration(
        hintText: 'Resim Url',
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the image URL';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
    );
  }

  Future<void> _ilanOlustur() async {
    if (formKey.currentState!.validate()) {
      // Form doğrulama başarılı, işlemleri gerçekleştir.
      try {
        String baslik = _baslikController.text;
        String aciklama = _aciklamaController.text;
        double fiyat = double.parse(_fiyatController.text);
        String tur = selectedType ?? ''; // Seçilen tip
        String email = _emailController.text;
        String image = _imageController.text;

        await FirebaseFirestore.instance.collection('Ilanlar').add({
          'baslik': baslik,
          'aciklama': aciklama,
          'fiyat': fiyat,
          'tur': tur,
          'email': email,
          'image': image,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ilan başarıyla oluşturuldu.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ilan oluşturulurken bir hata oluştu.'),
          ),
        );
      }
    }
  }
}
