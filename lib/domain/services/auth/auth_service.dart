import 'package:app_studiogenesis/data/data_source/api_data_source.dart';
import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/user/auth_user.dart';
import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_service_interface.dart';
import 'package:dartz/dartz.dart';

class AuthService implements AuthServiceInterface {
  final ApiDataSource api = ApiDataSource();

  @override
  Future<Either<Failure, AuthUser>> login(
      {String? username, String? email, required String password}) async {
    Map<String, String> map = {};

    if (username != null && username.isNotEmpty) {
      map['username'] = username;
    }

    if (email != null && email.isNotEmpty) {
      map['email'] = email;
    }
    map["password"] = password;
    map["password_confirmation"] = password;

    final res = await api.login(map);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, User>> me() async {
    final res = await api.me();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, AuthUser>> register(
      {required String name,
      required String lastname,
      required String username,
      required String birthdate,
      required String email,
      required String password,
      required String passwordVerified}) async {
    Map<String, String> map = {};

    map['name'] = name;
    map['lastname'] = lastname;
    map['birthdate'] = birthdate;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['password_confirmation'] = passwordVerified;

    final res = await api.register(map);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final res = await api.logout();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, User>> updatePassword(
      {required String password, required String passwordVerified}) async {
    Map<String, String> map = {};
    map['password'] = password;
    map['password_confirmation'] = passwordVerified;

    final res = await api.updatePassword(map);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, User>> updateUser(
      {String? name,
      String? lastname,
      String? username,
      String? birthdate,
      String? email}) async {
    Map<String, String> map = {};

    if (name != null) {
      map['name'] = name;
    }

    if (lastname != null) {
      map['lastname'] = lastname;
    }

    birthdate != null ? map['birthdate'] = birthdate : null;
    username != null ? map['username'] = username : null;
    email != null ? map['email'] = email : null;

    final res = await api.updateUser(map);

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
