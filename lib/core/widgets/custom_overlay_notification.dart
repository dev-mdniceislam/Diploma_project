import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomToast {
  // Error Toast Show Kora
  static void showError({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showNotification(
      title: message,
      subtitle: subtitle ?? "",
      backgroundColor: const Color(0xFFE53935), // Red
      icon: Icons.error_outline_rounded,
      duration: duration,
    );
  }

  // Success Toast Show Kora
  static void showSuccess({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showNotification(
      title: message,
      subtitle: subtitle,
      backgroundColor: const Color(0xFF43A047),
      icon: Icons.check_circle_outline_rounded,
      duration: duration,
    );
  }

  // Common UI Layout Function
  static void _showNotification({
    required String title,
    String? subtitle,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
  }) {
    showOverlayNotification(
      (context) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 380),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(60),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (subtitle != null && subtitle.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(50),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          OverlaySupportEntry.of(context)?.dismiss();
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      duration: duration,
    );
  }
}
