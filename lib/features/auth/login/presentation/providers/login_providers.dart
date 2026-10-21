import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../data/model/login_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/mock_auth_repository.dart';
import 'login_state.dart';

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepositoryImpl(),
);

// ========================== main notifier ========================
class LoginNotifier extends Notifier<LoginState> {
  LoginRepository get _repo => ref.read(loginRepositoryProvider);

  @override
  LoginState build() => const LoginState();

  Future<bool> login({required String email, required String password}) =>
      _authenticate(() => _repo.login(email: email, password: password));

  void logout() => state = const LoginState();

  void clearError() {
    if (state.error != null) state = state.copyWith(clearError: true);
  }

  Future<bool> _authenticate(Future<UserLoginModel?> Function() action) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await action();
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'কিছু একটা সমস্যা হয়েছে।',
        );
        CustomToast.showError(message: state.error.toString());

        return false;
      }
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      CustomToast.showError(message: e.toString());
      return false;
    }
  }
}

final loginNotifierProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
