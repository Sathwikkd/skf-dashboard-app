import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skf_project/features/auth/domain/usecase/auth_login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase _loginUseCase;
  AuthBloc({required AuthLoginUseCase usecase})
      : _loginUseCase = usecase,
        super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      final res = await _loginUseCase(
        UserDetails(
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (l) => emit(AuthLoginFailedState()),
        (r) => emit(AuthLoginSuccessState()),
      );
    });
  }
}
