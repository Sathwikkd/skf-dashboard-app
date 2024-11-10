part of 'drier_bloc.dart';

@immutable
sealed class DrierState {}

final class DrierInitial extends DrierState {}

final class DrierFetchSuccessState extends DrierState{
  final dynamic data;
  DrierFetchSuccessState({required this.data});
}

final class DrierFetchFailedState extends DrierState{
  final String message;
  final int errCode;
  DrierFetchFailedState({required this.message , required this.errCode});
}

final class DrierFetchLoadingState extends DrierState{}