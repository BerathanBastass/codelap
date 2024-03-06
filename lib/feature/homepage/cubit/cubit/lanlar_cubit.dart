import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'lanlar_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HomeCubit() : super(InitialState());

  void fetchData() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Profıl').doc('Baslik').get();
      emit(LoadedDataState(snapshot));
    } catch (e) {
      emit(ErrorState('Error fetching data: $e'));
    }
  }

  void deleteIlan(DocumentReference reference) {
    reference.delete().then((value) {
      print('İlan başarıyla silindi.');
    }).catchError((error) {
      print('İlanı silerken bir hata oluştu: $error');
    });
  }
}
