import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';

Future<void> openLink(BuildContext context, String url) async {
  final noLink = context.l10n.pfNoLink;
  final uri = Uri.tryParse(url);
  final ok = url.isNotEmpty &&
      uri != null &&
      await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok) CustomToast.showError(message: noLink);
}

Future<void> copyProfileLink(BuildContext context) async {
  final msg = context.l10n.pfLinkCopied;
  await Clipboard.setData(ClipboardData(text: Uri.base.toString()));
  CustomToast.showSuccess(message: msg);
}
