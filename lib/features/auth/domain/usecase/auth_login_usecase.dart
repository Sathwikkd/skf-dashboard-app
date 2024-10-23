import 'package:fpdart/fpdart.dart';
import 'package:skf_project/core/error/failure.dart';
import 'package:skf_project/core/usecase/usecase.dart';
import 'package:skf_project/features/auth/domain/repository/auth_repository.dart';

class AuthLoginUseCase implements UseCase<String, UserDetails> {
  final AuthRepository authLoginRepository;
  AuthLoginUseCase({required this.authLoginRepository});
  @override
  Future<Either<Failure, String>> call(UserDetails p) async {
    return await authLoginRepository.loginWithEmailAndPassword(
      email: p.email,
      password: p.password,
    );
  }
}

class UserDetails {
  final String email;
  final String password;
  UserDetails({
    required this.email,
    required this.password,
  });
}
