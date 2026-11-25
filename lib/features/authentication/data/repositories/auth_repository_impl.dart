import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote, this._local);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<void> sendOtp({required String email}) => _remote.sendOtp(email);

  @override
  Future<AuthUser> register(RegisterInput input, {required bool persist}) async {
    final model = await _remote.register(input);
    return _persist(model, persist);
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
    required bool persist,
  }) async {
    final model = await _remote.login(email: email, password: password);
    return _persist(model, persist);
  }

  @override
  Future<void> requestPasswordReset({required String email}) =>
      _remote.requestPasswordReset(email);

  @override
  Future<String> verifyResetOtp({
    required String email,
    required String otp,
  }) =>
      _remote.verifyResetOtp(email: email, otp: otp);

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) =>
      _remote.resetPassword(resetToken: resetToken, newPassword: newPassword);

  Future<AuthUser> _persist(AuthUserModel model, bool persist) async {
    if (persist) await _local.saveSession(model);
    return model.toEntity();
  }
}