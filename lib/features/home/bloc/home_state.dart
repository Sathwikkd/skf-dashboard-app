part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}



final class SubmitFeedbackSuccessState extends HomeState{
  final String message;
  SubmitFeedbackSuccessState({required this.message});
}

final class SubmitFeedbackFailureState extends HomeState{
  final String message;
  SubmitFeedbackFailureState({required this.message});
}

final class SubmitFeedbackLoadingState extends HomeState{}
