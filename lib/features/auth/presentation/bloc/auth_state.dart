part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState{}

final class AuthLoginSuccessState extends AuthState{}

final class AuthLoginFailedState extends AuthState{}
