import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class FetchDataEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class DeleteIlanEvent extends HomeEvent {
  final DocumentReference reference;

  DeleteIlanEvent(this.reference);

  @override
  List<Object?> get props => [reference];
}

// State
abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadedDataState extends HomeState {
  final DocumentSnapshot data;

  LoadedDataState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState extends HomeState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
