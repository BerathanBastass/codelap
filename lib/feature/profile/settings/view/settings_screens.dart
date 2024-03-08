import 'package:codelap/core/applocalizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/applocalizations/enums/enums.dart';
import '../../../../core/shared_preferences/shared_preferences.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/localizations_state.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedCardIndex =
        SharedPreferencesHelper.getData('lang') == 'de' ? 1 : 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.pageColor,
        title: Text(
          AppLocalizations.of(context).translate('Ayarlar'),
        ),
      ),
      backgroundColor: CustomColors.pageColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 1, 10, 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 1, 1, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context).translate('Dil'),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                buildCard(
                  1,
                  AppLocalizations.of(context).translate("Türkçe"),
                  FontAwesomeIcons.globe,
                  selectedCardIndex == 1,
                  () {
                    context
                        .read<LocalizationCubit>()
                        .appLanguageFunction(LanguagesTypesEnums.turkey);
                  },
                ),
                const SizedBox(height: 1),
                buildCard(
                  0,
                  AppLocalizations.of(context).translate("Almanca"),
                  FontAwesomeIcons.globe,
                  selectedCardIndex == 0,
                  () {
                    context
                        .read<LocalizationCubit>()
                        .appLanguageFunction(LanguagesTypesEnums.germany);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(int index, String language, IconData iconData,
      bool isSelected, VoidCallback onTap) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(15),
      color: isSelected ? CustomColors.purpleColor : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language,
                style: const TextStyle(color: Colors.black),
              ),
              Icon(
                iconData,
                size: 30,
                color: CustomColors.saltWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
