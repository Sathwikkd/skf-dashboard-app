part of 'stepcount_bloc.dart';

@immutable
sealed class StepcountState {}

final class StepcountInitial extends StepcountState {}

final class FetchStepCountSuccessState extends StepcountState{
  final int stepCount;
  FetchStepCountSuccessState({required this.stepCount});
}

final class FetchStepCointFailedState extends StepcountState{
  final String message;
  FetchStepCointFailedState({required this.message});
}

final class FetchStepCountLoadingState extends StepcountState{}
