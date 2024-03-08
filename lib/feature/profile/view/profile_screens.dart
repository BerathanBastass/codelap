import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/profile/settings/view/settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/applocalizations/app_localizations.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  late ProfileCubit _profileCubit;
  bool isLoading = false;
  final profileCubit = ProfileCubit().fetchData();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileCubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadedState) {
            t1.text = state.email;
            t2.text = state.phone;
          } else if (state is ProfileDataUpdatedState) {
          } else if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CustomColors.pageColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Settings(),
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.gear),
              ),
              title: const Text(
                "Profil",
                style: TextStyle(fontSize: 25),
              ),
            ),
            backgroundColor: CustomColors.pageColor,
            body: isLoading
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
        },
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
        _profileCubit.updateData(t1.text, t2.text);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: CustomColors.saltWhite,
      ),
      child: Text(
        AppLocalizations.of(context).translate('Kaydet'),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
