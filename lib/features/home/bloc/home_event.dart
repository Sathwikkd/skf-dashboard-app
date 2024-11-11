part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


class SubmitFeedbackEvent extends HomeEvent{
  final String message;
  SubmitFeedbackEvent({required this.message});
}
