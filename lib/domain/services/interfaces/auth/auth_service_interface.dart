import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/user/auth_user.dart';
import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthServiceInterface {
  Future<Either<Failure, AuthUser>> login(
      {String? username, String? email, required String password});
  Future<Either<Failure, User>> me();
  Future<Either<Failure, AuthUser>> register(
      {required String name,
      required String lastname,
      required String username,
      required String birthdate,
      required String email,
      required String password,
      required String passwordVerified});

  Future<Either<Failure, String>> logout();
}
