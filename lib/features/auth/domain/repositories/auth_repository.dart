import 'package:chatapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_model.dart';

abstract class AuthRepository{
  Future<Either<Failure,Unit>> loginWithGoogle(UserModel userModel);
}