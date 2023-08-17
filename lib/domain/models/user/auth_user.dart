import 'package:app_studiogenesis/domain/models/user/user.dart';

class AuthUser {
  final String token;
  final User user;
  AuthUser(this.token, this.user);

  static AuthUser fromJson(Map<String, dynamic> json) => AuthUser(
        json["token"],
        User.fromJson(json["user"]),
      );
}
