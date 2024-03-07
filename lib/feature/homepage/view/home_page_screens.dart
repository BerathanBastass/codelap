import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codelap/core/utils/colors.dart';
import 'package:codelap/feature/homepage/detail/view/advert_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit/lanlar_cubit.dart';
import '../cubit/cubit/lanlar_state.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
    _homeCubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit,
      child: Scaffold(
        backgroundColor: CustomColors.pageColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: CustomColors.pageColor,
            leading: null,
            automaticallyImplyLeading: false,
            title: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is LoadedDataState) {
                  var data = state.data.data() as Map<String, dynamic> ?? {};
                  var name = data['Name'] as String? ?? '';
                  return Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        body: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
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
                      builder: (context) =>
                          AdvertDetail(ilanID: snapshot.data!.docs[index].id),
                    ),
                  );
                },
                child: Card(
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
                            Text('Fiyat: $fiyat'),
                            Text('Tür: $tur'),
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
