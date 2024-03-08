abstract class IlanState {}

class IlanInitial extends IlanState {}

class IlanSuccess extends IlanState {}

class IlanError extends IlanState {
  final String errorMessage;

  IlanError({required this.errorMessage});
}
