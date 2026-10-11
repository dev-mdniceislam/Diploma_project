import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/widgets/app_container.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';

import '../../domain/entities/auth_enums.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_form_card.dart';
import '../widgets/auth_info_panel.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _fillDemo(UserRole role) {
    final l10n = context.l10n;
    ref.read(authRoleProvider.notifier).set(role);
    ref.read(authModeProvider.notifier).set(AuthMode.login);

    if (role == UserRole.student) {
      _email.text = 'sabbir.dpi@gmail.com';
      _password.text = 'Polytechnic2026!';
      CustomToast.showSuccess(message: l10n.demoStudentToast);
    } else {
      _email.text = 'hr@waltonbd.com';
      _password.text = 'CompanyAuth2026!';
      CustomToast.showSuccess(message: l10n.demoCompanyToast);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final form = AuthFormCard(
      emailController: _email,
      passwordController: _password,
    );
    final panel = AuthInfoPanel(onDemo: _fillDemo);

    return Scaffold(
      body: SingleChildScrollView(
        child: AppContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: scheme.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Responsive.isDesktop(context)
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 5, child: panel),
                          Expanded(flex: 6, child: form),
                        ],
                      ),
                    )
                  : Column(children: [panel, form]),
            ),
          ),
        ),
      ),
    );
  }
}
