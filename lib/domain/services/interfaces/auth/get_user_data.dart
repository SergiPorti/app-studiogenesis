import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:app_studiogenesis/domain/services/interfaces/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetUserData {
  static User? getUser(BuildContext context) {
    return (Provider.of<AuthManager>(context).currentState as UserVerifiedState)
        .user;
  }
}
