import 'package:fpdart/fpdart.dart';
import 'package:skf_project/core/error/exceptions.dart';
import 'package:skf_project/core/error/failure.dart';
import 'package:skf_project/features/auth/data/datasource/auth_datasource.dart';
import 'package:skf_project/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl({required this.authDatasource});
  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({required String email, required String password}) async {
    try { 
      var response = await authDatasource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(response.isEmpty) {
        return left(Failure(message: 'Unable to Login'));
      } 
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
