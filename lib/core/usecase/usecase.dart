import 'package:fpdart/fpdart.dart';
import 'package:skf_project/core/error/failure.dart';

abstract interface class UseCase<SuccessType , Parms>{
  Future<Either<Failure , SuccessType>> call(Parms p);
}