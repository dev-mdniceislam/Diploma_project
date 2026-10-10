import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // 403 Forbidden AlertDialog
  static void showForbiddenDialog() {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false, // Dialog এর বাইরে ক্লিক করলে পপআপ বন্ধ হবে না
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 8),
              Text("Session Expired"),
            ],
          ),
          content: const Text(
            "Your token has expired or access is forbidden. Please log in again to continue.",
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();

                // TODO: Clear saved Token (e.g. Shared Preferences)

                // Go to Login Screen and clear route stack
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', // আপনার Login Screen এর Route Name
                      (route) => false,
                );
              },
              child: const Text(
                "Go to Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}