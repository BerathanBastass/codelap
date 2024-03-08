// ignore_for_file: library_private_types_in_public_api

import 'package:codelap/feature/advert/cubit/lan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/applocalizations/app_localizations.dart';
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

  final List<String> types = [
    'Mobil Uyguluma',
    'Web Sitesi',
    'Oyun Geliştirme'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageColor,
      appBar: AppBar(
        leading: null,
        backgroundColor: CustomColors.pageColor,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).translate('İlanOlustur'),
        ),
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
                  _ilanOlustur(context);
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
                child: Text(
                  AppLocalizations.of(context).translate('Oluştur'),
                  style: const TextStyle(color: Colors.black),
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
        hintText: AppLocalizations.of(context).translate('Başlık'),
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
        hintText: AppLocalizations.of(context).translate('Açıklama'),
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
        hintText: AppLocalizations.of(context).translate('Fiyat'),
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
        hintText: AppLocalizations.of(context).translate('Tür'),
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
        hintText: AppLocalizations.of(context).translate('Resim'),
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

  Future<void> _ilanOlustur(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AdvertViewCubit cubit = context.read<AdvertViewCubit>();

      String baslik = _baslikController.text;
      String aciklama = _aciklamaController.text;
      double fiyat = double.parse(_fiyatController.text);
      String tur = selectedType ?? '';
      String email = _emailController.text;
      String image = _imageController.text;

      cubit.createAdvert(
        baslik: baslik,
        aciklama: aciklama,
        fiyat: fiyat,
        tur: tur,
        email: email,
        image: image,
      );
    }
  }
}
