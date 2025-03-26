import 'package:flutter/material.dart';
import 'notification_preferences.dart';
import 'notification_center.dart';

class NotificationPageRouter extends StatelessWidget {
  const NotificationPageRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if preferences have been selected
    bool preferencesSelected = false; // Replace with actual logic to check preferences

    return preferencesSelected
        ? const NotificationCenter() // Navigate to Notification Center if preferences are selected
        : const NotificationPreferences(); // Navigate to Notification Preferences otherwise
  }
}