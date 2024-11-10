part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccessState extends AuthState{}

final class AuthFailedState extends AuthState{
  final String message;
  AuthFailedState({required this.message});
}

final class AuthLoadingState extends AuthState{}


final class AuthLogoutSuccessState extends AuthState{}


final class AuthLogouteFailedState extends AuthState{
  final String message;
  AuthLogouteFailedState({required this.message});
}