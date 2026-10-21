import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/responsive/responsive_container.dart';
import 'login/widget/auth_form_card.dart';
import 'login/widget/auth_info_panel.dart';
import 'registration/domain/entities/auth_enums.dart';
import 'registration/presentation/providers/registration_provider.dart';

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
    ref.read(authRoleProvider.notifier).set(role);
    ref.read(authModeProvider.notifier).set(AuthMode.login);
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
        child: ResponsiveContainer(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
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
                        Expanded(flex: 6, child: panel),
                        Expanded(flex: 6, child: form),
                      ],
                    ),
                  )
                : Column(children: [panel, form]),
          ),
        ),
      ),
    );
  }
}
