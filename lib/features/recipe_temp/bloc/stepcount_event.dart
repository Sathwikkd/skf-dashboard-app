part of 'stepcount_bloc.dart';

@immutable
sealed class StepcountEvent {}

class FetchStepCount extends StepcountEvent{
  final String drierId;
  FetchStepCount({required this.drierId});
}
