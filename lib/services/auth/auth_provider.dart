import 'package:notedown/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn({
    required email,
    required password,
  });
  Future<AuthUser> createUser({
    required email,
    required password,
  });
  Future<void> logout();
  Future<void> sendEmailVerification();
}
