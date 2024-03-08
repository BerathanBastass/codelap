import 'package:bloc/bloc.dart';
import '../../../../core/applocalizations/enums/enums.dart';
import '../../../../core/shared_preferences/shared_preferences.dart';
import 'localizations_cubit.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  void appLanguageFunction(LanguagesTypesEnums language) {
    switch (language) {
      case LanguagesTypesEnums.initial:
        if (SharedPreferencesHelper.getData('lang') != null) {
          if (SharedPreferencesHelper.getData('lang') == 'tr') {
            emit(ChangeAppLanguage(languageCode: 'tr'));
          } else {
            emit(ChangeAppLanguage(languageCode: 'de'));
          }
        }
        break;
      case LanguagesTypesEnums.turkey:
        SharedPreferencesHelper.setData('lang', '');
        emit(ChangeAppLanguage(languageCode: 'tr'));
        break;
      case LanguagesTypesEnums.germany:
        SharedPreferencesHelper.setData('lang', 'de');
        emit(ChangeAppLanguage(languageCode: 'de'));
        break;
      default:
        emit(ChangeAppLanguage(languageCode: 'de'));
    }
  }
}
