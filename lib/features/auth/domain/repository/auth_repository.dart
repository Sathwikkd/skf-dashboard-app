import 'package:fpdart/fpdart.dart';
import 'package:skf_project/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure , String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}