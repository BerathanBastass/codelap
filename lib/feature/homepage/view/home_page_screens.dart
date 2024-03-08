import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/homepage/detail/view/advert_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/applocalizations/app_localizations.dart';
import '../cubit/cubit/lanlar_cubit.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit()..fetchData();

    return BlocProvider(
      create: (context) => homeCubit,
      child: Scaffold(
        backgroundColor: CustomColors.pageColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            leading: null,
            backgroundColor: CustomColors.pageColor,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context).translate('İlanlar'),
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        body: const _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Ilanlar').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Hata: ${snapshot.error}'),
          );
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var baslik = data['baslik'] ?? '';
              var fiyat = data['fiyat'] ?? '';
              var tur = data['tur'] ?? '';
              var image = data['image'] ?? '';

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvertDetail(
                        ilanID: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 30,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      ListTile(
                        title: Text(baslik),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                ' ${AppLocalizations.of(context).translate('Fiyat')}: $fiyat'),
                            Text(
                                '${AppLocalizations.of(context).translate('Tür')}: $tur'),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            homeCubit.deleteIlan(
                                snapshot.data!.docs[index].reference);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
