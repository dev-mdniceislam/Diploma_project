import 'package:diploma_job/core/l10n/app_localizations.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import '../../features/auth/registration/domain/entities/auth_enums.dart';

void notifyAuthResult(
  AppLocalizations l10n, {
  required bool ok,
  required UserRole role,
  bool registration = false,
}) {
  if (!ok) {
    CustomToast.showError(message: l10n.authFailed);
    return;
  }
  CustomToast.showSuccess(
    message: registration
        ? l10n.registerSuccess
        : role == UserRole.student
        ? l10n.loginStudentSuccess
        : l10n.loginCompanySuccess,
  );
}
