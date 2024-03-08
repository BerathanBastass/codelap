// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileCubit() : super(ProfileInitialState());

  void fetchData() async {
    emit(ProfileLoadingState());
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('Profıl').doc('Baslik').get();

      var data = documentSnapshot.data() as Map<String, dynamic>? ?? {};
      var email = data['Name'] as String? ?? '';
      var phone = data['Phone'] as String? ?? '';

      emit(ProfileLoadedState(email, phone));
    } catch (e) {
      print('Error fetching data: $e');
      emit(ProfileErrorState('Error fetching data: $e'));
    }
  }

  void updateData(String email, String phone) {
    emit(ProfileLoadingState());
    try {
      FirebaseFirestore.instance
          .collection('Profıl')
          .doc('Baslik')
          .set({'Name': email, 'Phone': phone});
      emit(ProfileDataUpdatedState());
    } catch (e) {
      print('Error updating data: $e');
      emit(ProfileErrorState('Error updating data: $e'));
    }
  }
}
