import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';

import '../../../../core/utils/auth_validators.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/labeled_text_field.dart';
import '../providers/auth_providers.dart';

class ForgotPasswordDialog extends ConsumerStatefulWidget {
  const ForgotPasswordDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const ForgotPasswordDialog(),
  );

  @override
  ConsumerState<ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);

    setState(() => _sending = true);
    await ref
        .read(authRepositoryProvider)
        .sendPasswordReset(_email.text.trim());
    navigator.pop();
    CustomToast.showSuccess(message: l10n.resetSent);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final validators = AuthValidators(l10n);

    return AppDialog(
      title: l10n.forgotTitle,
      maxWidth: 420,
      actions: [
        CustomButton(
          label: l10n.cancel,
          variant: CustomButtonVariant.outline,
          buttonHeight: 42,
          onPressed: () => Navigator.of(context).pop(),
        ),
        Opacity(
          opacity: _sending ? 0.6 : 1,
          child: CustomButton(
            label: l10n.sendLink,
            buttonHeight: 42,
            onPressed: _sending ? null : _send,
          ),
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(l10n.forgotMessage, style: AppTextStyles.bodySmall),
            const SizedBox(height: 16),
            LabeledTextField(
              label: l10n.fieldEmail,
              controller: _email,
              hintText: l10n.forgotEmailHint,
              preIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: validators.email,
              onSubmitted: (_) => _send(),
            ),
          ],
        ),
      ),
    );
  }
}
