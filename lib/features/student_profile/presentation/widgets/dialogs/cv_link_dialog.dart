import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../providers/student_profile_providers.dart';
import '../profile_core.dart';

class CvLinkDialog extends ConsumerStatefulWidget {
  const CvLinkDialog({super.key});

  static Future<void> show(BuildContext context) =>
      showDialog<void>(context: context, builder: (_) => const CvLinkDialog());

  @override
  ConsumerState<CvLinkDialog> createState() => _CvLinkDialogState();
}

class _CvLinkDialogState extends ConsumerState<CvLinkDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _url;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _url = TextEditingController(
      text: ref.read(studentProfileProvider).value?.cvUrl ?? '',
    );
  }

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);

    setState(() => _saving = true);
    try {
      await ref
          .read(studentProfileProvider.notifier)
          .updateCvLink(_url.text.trim());
      navigator.pop();
      CustomToast.showSuccess(message: l10n.cvUpdated);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppDialog(
      title: l10n.cvDialogTitle,
      actions: [
        CustomButton(
          label: l10n.cancel,
          variant: CustomButtonVariant.outline,
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
        ),
        CustomButton(
          label: l10n.update,
          isLoading: _saving,
          onPressed: _submit,
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledTextField(
              label: '${l10n.cvLinkLabel} *',
              controller: _url,
              hintText: 'https://drive.google.com/file/d/...',
              keyboardType: TextInputType.url,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return l10n.fieldRequired;
                final uri = Uri.tryParse(value);
                final ok = uri != null && uri.hasScheme && uri.host.isNotEmpty;
                return ok ? null : l10n.invalidUrl;
              },
            ),
            const SizedBox(height: AppDimens.xs + 2),
            CustomText(
              l10n.cvLinkNote,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
