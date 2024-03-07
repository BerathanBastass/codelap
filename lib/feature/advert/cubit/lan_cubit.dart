import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AdvertViewState { initial, success, error }

class AdvertViewCubit extends Cubit<AdvertViewState> {
  AdvertViewCubit() : super(AdvertViewState.initial);

  Future<void> createAdvert({
    required String baslik,
    required String aciklama,
    required double fiyat,
    required String tur,
    required String email,
    required String image,
  }) async {
    emit(AdvertViewState.initial);

    try {
      await FirebaseFirestore.instance.collection('Ilanlar').add({
        'baslik': baslik,
        'aciklama': aciklama,
        'fiyat': fiyat,
        'tur': tur,
        'email': email,
        'image': image,
      });

      emit(AdvertViewState.success);
    } catch (e) {
      emit(AdvertViewState.error);
    }
  }
}
