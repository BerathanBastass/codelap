import 'package:codelap/feature/advert/cubit/lan_cubit.dart';
import 'package:codelap/feature/auth/forgot_password/cubit/cubit/fpassword_cubit_cubit.dart';
import 'package:codelap/feature/auth/signup/view/signup_screens.dart';
import 'package:codelap/feature/bottombar/bottombar.dart';
import 'package:codelap/feature/homepage/cubit/cubit/lanlar_cubit.dart';
import 'package:codelap/feature/profile/cubit/profile_cubit.dart';
import 'package:codelap/feature/profile/settings/cubit/localizations_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/applocalizations/app_localizations.dart';
import 'core/applocalizations/enums/enums.dart';
import 'feature/auth/signup/cubit/signin_cubit.dart';
import 'feature/auth/signın/cubit/sign_n_cubit_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'feature/profile/settings/cubit/localizations_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static SharedPreferences? mainSharedPreferences;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<SignInCubit>(create: (context) => SignInCubit()),
        BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<AdvertViewCubit>(create: (context) => AdvertViewCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit()
            ..appLanguageFunction(LanguagesTypesEnums.initial),
        ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          if (state is ChangeAppLanguage) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              routes: {
                "/homePage": (context) => const BottomBar(),
              },
              home: const SignUpcreen(),
              locale: Locale(state.languageCode!),
              supportedLocales: const [
                Locale('tr'),
                Locale('de'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
