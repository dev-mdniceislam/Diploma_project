import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_overlay_notification.dart';

Future<void> openLink(BuildContext context, String url, String msg) async {
  final uri = Uri.tryParse(url);
  final ok =
      uri != null && await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok) CustomToast.showError(message: msg);
}
